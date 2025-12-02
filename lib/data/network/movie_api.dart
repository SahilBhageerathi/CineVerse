import 'package:inshorts_task/data/model/now_playing_response.dart';
import 'package:inshorts_task/data/model/trending_movie_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'movie_api.g.dart';

@RestApi()
abstract class MovieApi {
  factory MovieApi(Dio dio) = _MovieApi;

  @GET("/movie/popular")
  Future<TrendingMovieResponse> getPopularMovies(
    @Query("page") int page, {
    @Query("language") String language = "en-US",
  });

  @GET("/movie/now_playing")
  Future<NowPlayingResponse> getNowPlayingMovies(
    @Query("page") int page, {
    @Query("language") String language = "en-US",
  });

  @GET("/search/movie")
  Future<TrendingMovieResponse> searchMovies(
    @Query("query") String query,
    @Query("page") int page, {
    @Query("include_adult") bool includeAdult = false,
    @Query("language") String language = "en-US",
  });
}
