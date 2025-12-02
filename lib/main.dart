import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';
import 'package:inshorts_task/Core/Contants/global.dart';
import 'package:inshorts_task/data/local/movie_entity.dart';
import 'package:inshorts_task/di/injector.dart';
import 'Core/Contants/app_routes.dart';
import 'Presentation/Bloc/Home/home_bloc.dart';
import 'Presentation/Screens/splash_screen.dart';

late final AppLinks _appLinks;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Hive.initFlutter();
  Hive.registerAdapter(MovieEntityAdapter());
await Hive.openBox<MovieEntity>(GlobalConstant.moviesBox);
await Hive.openBox<List<int>>(GlobalConstant.popularIdsBox);
await Hive.openBox<List<int>>(GlobalConstant.nowPlayingIdsBox);

  _appLinks = AppLinks();
  _appLinks.uriLinkStream.listen((uri) {
    if (uri.host == "www.cineverse.com" && uri.pathSegments.isNotEmpty) {
      if (uri.pathSegments.first == "movie") {
        final movieId = int.tryParse(uri.queryParameters["id"] ?? "");
        if (movieId != null) {
          GlobalConstant.navigatorKey.currentState?.pushReplacementNamed(
            AppRoutes.movieDetailsScreen,
            arguments: movieId,
          );
        }
      }
    }
  });

  HttpOverrides.global = MyHttpOverrides();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child:BlocProvider(
        create: (context) => HomeBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGeneratedRoute,
          title: AppStrings.appName,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
          navigatorKey: GlobalConstant.navigatorKey,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
