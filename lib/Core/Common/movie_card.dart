import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';

class MovieCard extends StatefulWidget {
  final VoidCallback? onTapOfMovieCard;
  final double customHeight;
  final double customWidth;

   MovieCard({
    super.key,
    this.onTapOfMovieCard,
    this.customHeight = AppDimensions.defaultMovieCardHeight,
    this.customWidth = AppDimensions.defaultMovieCardWidth
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
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5.r)),
      ),
    );
  }
}
