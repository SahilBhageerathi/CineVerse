import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';
import 'package:inshorts_task/Core/Contants/app_routes.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';
import 'package:inshorts_task/Core/Contants/global.dart';
import 'package:inshorts_task/Presentation/Bloc/Home/home_bloc.dart';
import 'package:inshorts_task/Utils/extensions.dart';
import 'package:inshorts_task/resources/colors/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(InitializeSearchPage());
  }

  @override
  void dispose() {
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 400), () async {
      if (query.isEmpty) {
        return;
      }
      context.read<HomeBloc>().add(OnSearchChanged(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight.h,
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            title: SizedBox(
              width: double.infinity,
              child: Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.padding12.w,
                      vertical: AppDimensions.padding10.h,
                    ),
                    border: InputBorder.none,
                    hintText: AppStrings.searchPlaceHolder,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              searchController.clear();
                              setState(() => state.searchMovieResults = []);
                            },
                            child: const Icon(Icons.close),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),

          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.searchMovieResults.isEmpty
              ? Center(
                  child: Text(
                    AppStrings.searchPagePlaceHolder,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.padding12.h,
                    horizontal: AppDimensions.padding12.w,
                  ),
                  itemCount: state.searchMovieResults.length,
                  itemBuilder: (_, index) {
                    final movie = state.searchMovieResults[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: AppDimensions.padding12.h),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.movieDetailsScreen,
                            arguments: movie,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              // Poster Image
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.r),
                                  bottomLeft: Radius.circular(12.r),
                                ),
                                child: movie.posterPath != null
                                    ? Image.network(
                                        "${GlobalConstant.imageUrl}${movie.posterPath}",
                                        width: 90.w,
                                        height: 130.h,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 90.w,
                                        height: 130.h,
                                        color: Colors.black26,
                                        child: const Icon(Icons.image_not_supported, size: 30),
                                      ),
                              ),

                              12.ws,
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppDimensions.padding10.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      6.hs,
                                      Text(
                                        movie.releaseDate?.split("-").first ??
                                            AppStrings.unknownTxt,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      8.hs,
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.amber, size: 18.sp),
                                          4.ws,
                                          Text(
                                            movie.voteAverage.toStringAsFixed(1),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
