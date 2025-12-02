import 'package:hive/hive.dart';
import 'package:inshorts_task/Core/Contants/global.dart';
import 'package:inshorts_task/Utils/extensions.dart';
import 'package:inshorts_task/data/model/now_playing_response.dart';
import 'package:inshorts_task/data/model/trending_movie_response.dart';
import 'package:inshorts_task/data/network/movie_api.dart';
import '../model/movie.dart';
import 'package:inshorts_task/data/local/movie_entity.dart';

class MovieRepository {
  final MovieApi api;
  final Box<MovieEntity> movieBox;
  final Box<List<int>> popularIdsBox;
  final Box<List<int>> nowPlayingIdsBox;

  MovieRepository(this.api, this.movieBox, this.popularIdsBox, this.nowPlayingIdsBox);

  Map<int, Movie> getMoviesDb() {
    final map = <int, Movie>{};
    for (var e in movieBox.values) {
      map[e.id] = e.toModel();
    }
    return map;
  }

  Future<void> saveMoviesDb(Map<int, Movie> moviesDb) async {
    for (final m in moviesDb.values) {
      movieBox.put(m.id, m.toEntity());
    }
  }

  List<int> getTrendingIds() {
    return popularIdsBox.get(GlobalConstant.popular) ?? [];
  }

  Future<void> saveTrendingIds(List<int> ids) async {
    await popularIdsBox.put(GlobalConstant.popular, ids);
  }

  List<int> getNowPlayingIds() {
    return nowPlayingIdsBox.get(GlobalConstant.nowPlaying) ?? [];
  }

  Future<void> saveNowPlayingIds(List<int> ids) async {
    await nowPlayingIdsBox.put(GlobalConstant.nowPlaying, ids);
  }

  Future<TrendingMovieResponse> fetchTrendingMovies(int page) async {
    return await api.getPopularMovies(page);
  }

  Future<NowPlayingResponse> fetchNowPlayingMovies(int page) async {
    return await api.getNowPlayingMovies(page);
  }

  Future<void> toggleBookmark(int id) async {
    final entity = movieBox.get(id);
    if (entity != null) {
      entity.bookMarked = !entity.bookMarked;
      await entity.save();
    }
  }

  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final resp = await api.searchMovies(query, page);
    final movies = resp.results;
    movies.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
    return movies;
  }
}
