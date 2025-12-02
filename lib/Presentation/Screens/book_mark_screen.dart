import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_task/Core/Common/movie_card.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';
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
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: bookmarkedMovies.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: bookmarkedMovies[index],
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
