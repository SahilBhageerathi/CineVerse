import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:inshorts_task/data/model/movie.dart';
import 'package:inshorts_task/data/repository/movie_repository.dart';
import 'package:inshorts_task/di/injector.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository movieRepo = sl<MovieRepository>();

  HomeBloc() : super(HomeState()) {
    on<InitializeHomePage>(initialize);
    on<LoadMorePopular>(loadMorePopular);
    on<LoadMoreNowPlaying>(loadMoreNowPlaying);
    on<ToggleBookmark>(onToggleBookmark);
    on<InitializeSearchPage>(initSearchPage);
    on<OnSearchChanged>(onSearchChanged);
  }

  FutureOr<void> initialize(InitializeHomePage event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final cachedMovies = movieRepo.getMoviesDb().values.toList();
      final cachedTrendingIds = movieRepo.getTrendingIds();
      final cachedNowPlayingIds = movieRepo.getNowPlayingIds();

      final hasCachedData =
          cachedMovies.isNotEmpty && cachedTrendingIds.isNotEmpty && cachedNowPlayingIds.isNotEmpty;

      if (hasCachedData) {
        emit(
          state.copyWith(
            isLoading: false,
            allMovies: cachedMovies,
            trendingMovieIds: cachedTrendingIds,
            nowPlayingMovieIds: cachedNowPlayingIds,
          ),
        );
        return;
      }

      final trendingResp = await movieRepo.fetchTrendingMovies(1);
      final nowPlayingResp = await movieRepo.fetchNowPlayingMovies(1);

      final mergedMovies = <int, Movie>{};

      for (var m in trendingResp.results) {
        mergedMovies[m.id] = m;
      }

      for (var m in nowPlayingResp.results) {
        mergedMovies[m.id] = m;
      }

      await movieRepo.saveMoviesDb(mergedMovies);
      await movieRepo.saveTrendingIds(trendingResp.results.map((e) => e.id).toList());
      await movieRepo.saveNowPlayingIds(nowPlayingResp.results.map((e) => e.id).toList());

      emit(
        state.copyWith(
          isLoading: false,
          allMovies: mergedMovies.values.toList(),
          trendingMovieIds: trendingResp.results.map((e) => e.id).toList(),
          nowPlayingMovieIds: nowPlayingResp.results.map((e) => e.id).toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> onToggleBookmark(ToggleBookmark event, Emitter<HomeState> emit) async {
    await movieRepo.toggleBookmark(event.movieId);
    final updated = movieRepo.getMoviesDb().values.toList();
    emit(state.copyWith(allMovies: updated));
  }

  FutureOr<void> loadMorePopular(LoadMorePopular event, Emitter<HomeState> emit) async {
    if (state.isLoadingMore) return;
    try {
      emit(state.copyWith(isLoadingMore: true));

      int page = state.currentPopularPage + 1;
      final response = await movieRepo.fetchTrendingMovies(page);
      final newMovies = response.results;
      final newIds = newMovies.map((m) => m.id).toList();

      final updatedIds = [...state.trendingMovieIds, ...newIds];

      final updatedAllMovies = [...state.allMovies];
      for (final m in newMovies) {
        if (!updatedAllMovies.any((x) => x.id == m.id)) {
          updatedAllMovies.add(m);
        }
      }

      emit(
        state.copyWith(
          currentPopularPage: page,
          trendingMovieIds: updatedIds,
          allMovies: updatedAllMovies,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  FutureOr<void> loadMoreNowPlaying(LoadMoreNowPlaying event, Emitter<HomeState> emit) async {
    if (state.isLoadingMore) return;
    try {
      emit(state.copyWith(isLoadingMore: true));

      int page = state.currentNowPlayingPage + 1;
      final response = await movieRepo.fetchNowPlayingMovies(page);
      final newMovies = response.results;
      final newIds = newMovies.map((m) => m.id).toList();

      final updatedIds = [...state.nowPlayingMovieIds, ...newIds];

      final updatedAllMovies = [...state.allMovies];
      for (final m in newMovies) {
        if (!updatedAllMovies.any((x) => x.id == m.id)) {
          updatedAllMovies.add(m);
        }
      }

      emit(
        state.copyWith(
          currentNowPlayingPage: page,
          nowPlayingMovieIds: updatedIds,
          allMovies: updatedAllMovies,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  FutureOr<void> onSearchChanged(OnSearchChanged event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final res = await movieRepo.searchMovies(event.query);

      emit(state.copyWith(isLoading: false, searchMovieResults: res));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  FutureOr<void> initSearchPage(InitializeSearchPage event, Emitter<HomeState> emit) {
    state.searchMovieResults = [];
    emit(state.copyWith(searchMovieResults: []));
  }
}
