import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';

@JsonSerializable()
class Movie extends Equatable {
  final int id;
  final String title;

  @JsonKey(name: "original_title")
  final String originalTitle;

  @JsonKey(name: "original_language")
  final String originalLanguage;

  final String overview;

  @JsonKey(name: "release_date")
  final String? releaseDate;

  final bool adult;
  final bool video;

  @JsonKey(name: "backdrop_path")
  final String? backdropPath;

  @JsonKey(name: "poster_path")
  final String? posterPath;

  @JsonKey(name: "genre_ids")
  final List<int> genreIds;

  final double popularity;

  @JsonKey(name: "vote_average")
  final double voteAverage;

  @JsonKey(name: "vote_count")
  final int voteCount;


  bool isBookmarked;

  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.originalLanguage,
    required this.overview,
    required this.releaseDate,
    required this.adult,
    required this.video,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIds,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    this.isBookmarked = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  List<Object?> get props => [
    id,
    title,
    originalTitle,
    originalLanguage,
    overview,
    releaseDate,
    adult,
    video,
    backdropPath,
    posterPath,
    genreIds,
    popularity,
    voteAverage,
    voteCount,
    isBookmarked
  ];
}





