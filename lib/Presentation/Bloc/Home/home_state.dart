part of 'home_bloc.dart';

class HomeState {
  bool isLoading = false;
  bool isLoadingMore = false;
  int currentPage = 1;

  List<Movie> trendingMovies = [];//consider this as popular movies
  List<Movie> nowPlayingMovies = [];

  int currentPopularPage = 1;
  int currentNowPlayingPage = 1;
  List<Movie> allMovies=[];
  List<int> trendingMovieIds=[];
  List<int> nowPlayingMovieIds=[];
  List<Movie> searchMovieResults = [];

  HomeState copyWith({
    bool? isLoading,
    List<Movie>? trendingMovies,
    List<Movie>? nowPlayingMovies,

    int? currentPopularPage,
    int? currentNowPlayingPage,
    List<Movie>? allMovies,
    List<Movie>? searchMovieResults,
    List<int>? trendingMovieIds,
    List<int>? nowPlayingMovieIds,

    bool? isLoadingMore,
    int? currentPage,
  }) {
    HomeState newState = HomeState();
    newState.isLoading = isLoading ?? this.isLoading;
    newState.trendingMovies = trendingMovies ?? this.trendingMovies;
    newState.nowPlayingMovies = nowPlayingMovies ?? this.nowPlayingMovies;

    newState.allMovies = allMovies ?? this.allMovies;
    newState.trendingMovieIds = trendingMovieIds ?? this.trendingMovieIds;
    newState.nowPlayingMovieIds = nowPlayingMovieIds ?? this.nowPlayingMovieIds;
    newState.currentPopularPage = currentPopularPage ?? this.currentPopularPage;
    newState.currentNowPlayingPage = currentNowPlayingPage ?? this.currentNowPlayingPage;
    newState.searchMovieResults = searchMovieResults ?? this.searchMovieResults;

    newState.isLoadingMore = isLoadingMore ?? this.isLoadingMore;
    newState.currentPage = currentPage ?? this.currentPage;
    return newState;
  }
}
