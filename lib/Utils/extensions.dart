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


class GenreHelper {
  static const Map<int, String> genres = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western",
  };
}


extension MovieGenreExtension on Movie {
  List<String> get genreNames {
    return genreIds.map((id) => GenreHelper.genres[id] ?? "Unknown").toList();
  }
}