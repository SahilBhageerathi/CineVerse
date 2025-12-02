import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/Core/Common/movie_card.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';
import 'package:inshorts_task/Core/Contants/app_routes.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';
import 'package:inshorts_task/Presentation/Bloc/Home/home_bloc.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(

      builder: (context, state) {
        final bookmarkedMovies = state.allMovies.where((m) => m.isBookmarked == true).toList();
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(AppDimensions.padding8),
            child: bookmarkedMovies.isEmpty
                ? Center(
                    child: Text(
                      AppStrings.bookMarkPagePlaceHolder,
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: bookmarkedMovies.length,
                    itemBuilder: (context, index) {
                      var movie = bookmarkedMovies[index];
                      return MovieCard(
                        movie: movie,
                        onTapOfMovieCard: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.movieDetailsScreen,
                            arguments: movie,
                          );
                        },
                        onTapBookmark: () {
                          context.read<HomeBloc>().add(ToggleBookmark(bookmarkedMovies[index].id));
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
