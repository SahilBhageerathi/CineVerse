import 'package:flutter/material.dart';

class GlobalConstant{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const moviesBox = 'movies';
  static const popularIdsBox = 'popularIdsBox';
  static const popular = 'popular';
  static const nowPlayingIdsBox = 'nowPlayingIdsBox';
  static const nowPlaying = 'nowPlaying';
  static const popularIdsInstanceNme = 'popularIds';
  static const nowPlayingInstanceName = 'nowPlayingIds';
  static const imageUrl = 'https://image.tmdb.org/t/p/w500';
}