import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';
import 'package:inshorts_task/Core/Contants/app_routes.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';
import 'package:inshorts_task/Presentation/Bloc/Home/home_bloc.dart';
import 'package:inshorts_task/Presentation/Screens/book_mark_screen.dart';
import 'package:inshorts_task/Presentation/Screens/trending_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> tabs = [
    Tab(icon: Icon(Icons.home), text: AppStrings.trendingText),
    Tab(icon: Icon(Icons.bookmark), text: AppStrings.bookMarkText),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: kToolbarHeight / 2,
              left: AppDimensions.paddingSmall,
              right: AppDimensions.paddingSmall,
            ),
            child: Stack(
              children: [
                TabBarView(
                  controller: _tabController,
                  children: const [TrendingScreen(), BookMarkScreen()],
                ),
                Positioned(
                  bottom: kToolbarHeight,
                  right: 10.w,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.searchScreen);
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Icon(Icons.search, size: 24.h),
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
      },
    );
  }
}
