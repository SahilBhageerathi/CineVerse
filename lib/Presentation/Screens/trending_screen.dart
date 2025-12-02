import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_task/Core/Common/movie_card.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';
import 'package:inshorts_task/Core/Contants/app_routes.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';
import 'package:inshorts_task/Presentation/Bloc/Home/home_bloc.dart';
import 'package:inshorts_task/data/model/movie.dart';
import 'package:inshorts_task/resources/colors/app_colors.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        final trendingMovies = state.trendingMovieIds
            .map((id) => state.allMovies.firstWhere((m) => m.id == id))
            .toList();

        final nowPlayingMovies = state.nowPlayingMovieIds
            .map((id) => state.allMovies.firstWhere((m) => m.id == id))
            .toList();

        return Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: AppStrings.trendingText),
                Tab(text: AppStrings.nowPlayingText),
              ],
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  createMovieGrid(trendingMovies, context, isTrending: true),
                  createMovieGrid(nowPlayingMovies, context, isTrending: false),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget createMovieGrid(List<Movie> movies, BuildContext context, {required bool isTrending}) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(InitializeHomePage());
        await Future.delayed(const Duration(seconds: 1));
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
            context.read<HomeBloc>().add(
              isTrending ? LoadMorePopular() : LoadMoreNowPlaying(),
            );
          }
          return false;
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(AppDimensions.padding8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieCard(
              movie: movies[index],
              onTapOfMovieCard: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.movieDetailsScreen,
                  arguments: movies[index],
                );
              },
              onTapBookmark: () {
                context.read<HomeBloc>().add(ToggleBookmark(movies[index].id));
              },
            );
          },
        ),
      ),
    );
  }
}

