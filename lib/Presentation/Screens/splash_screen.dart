import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inshorts_task/Core/Contants/app_routes.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(SvgImages.logo,
            //       width: SplashScreen.splashIconSize.h, height: SplashScreen.splashIconSize.h),
            Text(AppStrings.welcomeText, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
