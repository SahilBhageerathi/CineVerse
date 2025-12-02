import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'movie.dart';

part 'trending_movie_response.g.dart';

@JsonSerializable()
class TrendingMovieResponse extends Equatable{
  final int page;

  @JsonKey(name: "total_pages")
  final int totalPages;

  @JsonKey(name: "total_results")
  final int totalResults;

  final List<Movie> results;

  const TrendingMovieResponse({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory TrendingMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$TrendingMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingMovieResponseToJson(this);

  @override
  List<Object?> get props => [
    page,
    totalPages,
    totalResults,
    results,
  ];
}

