import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';
import 'package:inshorts_task/Core/Contants/global.dart';
import 'package:inshorts_task/Utils/extensions.dart';
import 'package:inshorts_task/data/model/movie.dart';
import 'package:inshorts_task/resources/colors/app_colors.dart';

class MovieCard extends StatefulWidget {
  final VoidCallback? onTapOfMovieCard;
  final VoidCallback? onTapBookmark;
  final double customHeight;
  final double customWidth;
  final Movie? movie;

  const MovieCard({
    super.key,
    this.onTapOfMovieCard,
    this.onTapBookmark,
    this.customHeight = AppDimensions.defaultMovieCardHeight,
    this.customWidth = AppDimensions.defaultMovieCardWidth,
    this.movie,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapOfMovieCard,
      child: Container(
        height: widget.customHeight.h,
        width: widget.customWidth.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: widget.movie == null ? AppColors.primaryColor : Colors.transparent,
        ),
        child: widget.movie != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "${GlobalConstant.imageUrl}${widget.movie!.posterPath}",
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>  Container(
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      errorWidget: (_, __, ___) => const Icon(Icons.broken_image,color: Colors.blue),
                    ),
                    widget.movie != null
                        ? Positioned(
                            right: 6.w,
                            top: 6.h,
                            child: GestureDetector(
                              onTap: () {
                                widget.onTapBookmark?.call();
                              },
                              child: Icon(
                                widget.movie!.isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.5),
                        padding: EdgeInsets.all(6.w),
                        child: Text(
                          widget.movie!.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
