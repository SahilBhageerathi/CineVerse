import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';
import 'package:inshorts_task/Core/Contants/app_routes.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';
import 'package:inshorts_task/Core/Contants/global.dart';
import 'package:inshorts_task/Presentation/Bloc/Home/home_bloc.dart';
import 'package:inshorts_task/Presentation/Screens/book_mark_screen.dart';
import 'package:inshorts_task/Presentation/Screens/trending_screen.dart';
import 'package:inshorts_task/resources/colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> tabs = [
    Tab(icon: Icon(Icons.home), text: AppStrings.homeText),
    Tab(icon: Icon(Icons.bookmark), text: AppStrings.bookMarkText),
  ];

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(InitializeHomePage());
    Future.sync(() async {
      AppLinks appLinks = AppLinks();
      final uri = await appLinks.getInitialLink();
      if (uri != null) {
        if (uri.host == "www.cineverse.com" && uri.pathSegments.isNotEmpty) {
          if (uri.pathSegments.first == "movie") {
            final movieId = int.tryParse(uri.queryParameters["id"] ?? "");
            if (movieId != null && mounted && !context.read<HomeBloc>().state.comingBackFromDetailsPage) {
              GlobalConstant.navigatorKey.currentState?.pushNamed(
                AppRoutes.movieDetailsScreen,
                arguments: movieId,
              );
            }
          }
        }
      }
    });

    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: kToolbarHeight / 2,
          left: AppDimensions.padding8,
          right: AppDimensions.padding8,
        ),
        child: Stack(
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [TrendingScreen(), BookMarkScreen()],
            ),
            Positioned(
              bottom: kToolbarHeight/5,
              right: 10.w,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.searchScreen);
                },
                child: Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Icon(Icons.search, size: 24.h,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60.h,
        child: Material(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            tabs: tabs,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicator: UnderlineTabIndicator(
              borderSide: const BorderSide(width: 3, color: Colors.black),
              insets: EdgeInsets.fromLTRB(0, 0, 0, 60.h),
            ),
          ),
        ),
      ),
    );
  }
}
