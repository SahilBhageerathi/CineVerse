import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/data/local/movie_entity.dart';
import '../data/model/movie.dart';

extension IntExtention on int {
  SizedBox get hs {
    final sizedBox = SizedBox(height: h);
    return sizedBox;
  }

  SizedBox get ws {
    final sizedBox = SizedBox(width: w);
    return sizedBox;
  }
}


extension MovieToEntity on Movie {
  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      originalTitle: originalTitle,
      originalLanguage: originalLanguage,
      overview: overview,
      releaseDate: releaseDate,
      adult: adult,
      video: video,
      backdropPath: backdropPath,
      posterPath: posterPath,
      genreIds: genreIds,
      popularity: popularity,
      voteAverage: voteAverage,
      voteCount: voteCount,
      bookMarked: isBookmarked,
    );
  }
}

extension EntityToMovie on MovieEntity {
  Movie toModel() {
    return Movie(
      id: id,
      title: title,
      originalTitle: originalTitle,
      originalLanguage: originalLanguage,
      overview: overview,
      releaseDate: releaseDate,
      adult: adult,
      video: video,
      backdropPath: backdropPath,
      posterPath: posterPath,
      genreIds: genreIds,
      popularity: popularity,
      voteAverage: voteAverage,
      voteCount: voteCount,
      isBookmarked: bookMarked,
    );
  }
}