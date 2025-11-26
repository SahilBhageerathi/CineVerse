import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/Core/Contants/app_constants.dart';
import 'package:inshorts_task/Core/Contants/global.dart';
import 'package:inshorts_task/Presentation/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: ScreenUtil().pixelRatio,
      child: MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        navigatorKey: GlobalConstant.navigatorKey,
        home: const SplashScreen(),
      ),
    );
  }
}
