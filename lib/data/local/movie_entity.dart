import 'package:hive/hive.dart';

part 'movie_entity.g.dart';

@HiveType(typeId: 0)
class MovieEntity extends HiveObject {
  @HiveField(0) int id;
  @HiveField(1) String title;
  @HiveField(2) String originalTitle;
  @HiveField(3) String originalLanguage;
  @HiveField(4) String overview;
  @HiveField(5) String? releaseDate;
  @HiveField(6) bool adult;
  @HiveField(7) bool video;
  @HiveField(8) String? backdropPath;
  @HiveField(9) String? posterPath;
  @HiveField(10) List<int> genreIds;
  @HiveField(11) double popularity;
  @HiveField(12) double voteAverage;
  @HiveField(13) int voteCount;
  @HiveField(14,defaultValue: false) bool bookMarked;


  MovieEntity({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.originalLanguage,
    required this.overview,
    this.releaseDate,
    required this.adult,
    required this.video,
    this.backdropPath,
    this.posterPath,
    required this.genreIds,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    this.bookMarked=false,
  });
}
