import 'package:flutter/material.dart';
import 'package:inshorts_task/Presentation/Screens/book_mark_screen.dart';
import 'package:inshorts_task/Presentation/Screens/home_page.dart';
import 'package:inshorts_task/Presentation/Screens/movie_details_screen.dart';
import 'package:inshorts_task/Presentation/Screens/search_screen.dart';
import 'package:inshorts_task/Presentation/Screens/splash_screen.dart';
import 'package:inshorts_task/Presentation/Screens/trending_screen.dart';

class AppRoutes{
  static const String splashScreen = '/';
  static const String homeScreen = '/homeScreen';
  static const String bookMarkScreen = '/bookMarkScreen';
  static const String trendingScreen = '/trendingScreen';
  static const String searchScreen = '/searchScreen';
  static const String movieDetailsScreen = '/movieDetailsScreen';

  static Route? onGeneratedRoute(RouteSettings routeSettings) {
    debugPrint('Current Route is  ${routeSettings.name}');
    switch (routeSettings.name) {

      case splashScreen:
        return PageRouteBuilder(
          settings: routeSettings,
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (_, animation, __) =>
              FadeTransition(opacity: animation, child: const SplashScreen()),
        );

      case homeScreen:
        return _buildPageRoute(const HomeScreen(), routeSettings);

      case bookMarkScreen:
        return _buildPageRoute(const BookMarkScreen(), routeSettings);

      case trendingScreen:
        return _buildPageRoute(const TrendingScreen(), routeSettings);

      case searchScreen:
        return _buildPageRoute(const SearchScreen(), routeSettings);

      case movieDetailsScreen:
        return _buildPageRoute(const MovieDetailsScreen(), routeSettings);
    }
  }

  static PageRouteBuilder _buildPageRoute(Widget screen, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return screen;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}