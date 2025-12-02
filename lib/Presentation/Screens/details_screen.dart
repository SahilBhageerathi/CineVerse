import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';
import 'package:inshorts_task/Core/Contants/app_routes.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';
import 'package:inshorts_task/Core/Contants/global.dart';
import 'package:inshorts_task/Presentation/Bloc/Home/home_bloc.dart';
import 'package:inshorts_task/Utils/extensions.dart';
import 'package:inshorts_task/data/model/movie.dart';
import 'package:inshorts_task/resources/colors/app_colors.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie? movie;
  final int? movieId;

  const MovieDetailsScreen({super.key, this.movie, this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState1();
}

class _MovieDetailsScreenState1 extends State<MovieDetailsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  Movie? m;

  @override
  void initState() {
    super.initState();
    if (widget.movie == null && widget.movieId != null) {
      context.read<HomeBloc>().add(GetMovieEvent(widget.movieId!));
    }
    _tabController = TabController(length: 3, vsync: this);
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
        m = widget.movie ?? state.movieFromDeepLink;
        return WillPopScope(
          onWillPop: () async {
            if (state.movieFromDeepLink != null) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeScreen,
                    (route) => false,
              );
              context.read<HomeBloc>().add(OpenDetailsPageFromDeepLink(true));
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            backgroundColor: m == null ? Colors.white : const Color(0xff1A1C22),
            extendBodyBehindAppBar: true,
            appBar: m == null
                ? AppBar(automaticallyImplyLeading: false)
                : AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: InkWell(
                        onTap: () {
                          if (state.movieFromDeepLink != null) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.homeScreen,
                              (route) => false,
                            );
                            context.read<HomeBloc>().add(OpenDetailsPageFromDeepLink(true));
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          setState(() => m!.isBookmarked = m!.isBookmarked);
                          context.read<HomeBloc>().add(ToggleBookmark(m!.id));
                        },
                        icon: Icon(
                          m!.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
            body: m == null
                ? 0.hs
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 300.h,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: "${GlobalConstant.imageUrl}${m!.backdropPath}",
                            fit: BoxFit.scaleDown,
                            placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (_, __, ___) => const Icon(Icons.error),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120.h,
                                width: 85.w,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                                child: CachedNetworkImage(
                                  imageUrl: "${GlobalConstant.imageUrl}${m!.posterPath}",
                                  fit: BoxFit.scaleDown,
                                  placeholder: (_, __) =>
                                      const Center(child: CircularProgressIndicator()),
                                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                                ),
                              ),
                              12.ws,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      m!.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    10.hs,
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 20),
                                        4.ws,
                                        Text(
                                          m!.voteAverage.toString(),
                                          style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customIcon(Icons.date_range, m!.releaseDate ?? "N/A"),
                            separatorDot(),
                            customIcon(Icons.favorite, m!.popularity.toString()),
                            separatorDot(),
                            customIcon(Icons.movie_filter, m!.genreNames.join(", ")),
                          ],
                        ),
                        20.hs,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: Colors.white,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: AppStrings.aboutMovie),
                              Tab(text: AppStrings.reviews),
                              Tab(text: AppStrings.cast),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 350.h,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.padding20.w,
                                  vertical: AppDimensions.padding16.h,
                                ),
                                child: Text(
                                  m!.overview,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16.sp,
                                    height: 1.4,
                                  ),
                                ),
                              ),

                              Center(
                                child: Text(
                                  AppStrings.reviewsPlaceHolder,
                                  style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                                ),
                              ),

                              Center(
                                child: Text(
                                  AppStrings.castPlaceHolder,
                                  style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            floatingActionButton: InkWell(
              onTap: () {
                final movieId = m!.id;
                final title = m!.title;
                final link = "https://www.cineverse.com/movie?id=$movieId";
                context.read<HomeBloc>().add(
                  ShareMovieEvent("Check out this movie \n$title\n$link"),
                );
              },
              child: Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Icon(Icons.share, size: 24.h, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget separatorDot() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    child: const Text("•", style: TextStyle(color: Colors.white70)),
  );

  Widget customIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white70),
        4.ws,
        Text(limitText(label), style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  String limitText(String text) {
    if (text.length <= 12) {
      return text;
    } else {
      return "${text.substring(0, 12)}...";
    }
  }
}
