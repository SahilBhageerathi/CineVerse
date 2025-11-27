import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inshorts_task/Presentation/Screens/widgets/expandable_text.dart';
import 'package:inshorts_task/Core/Common/movie_card.dart';
import 'package:inshorts_task/Core/Contants/app_dimensions.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';
import 'package:inshorts_task/Utils/extensions.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.62),
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20.r)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EVIL DEAD RISE" * 5,
                    style: TextStyle(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  5.hs,
                  Text("Horror", style: TextStyle(color: Colors.white)),
                  Divider(thickness: 2.h),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Column(
                      children: [
                        Text("Censor Rating", style: TextStyle(color: Colors.white)),
                        Text("A", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Duration", style: TextStyle(color: Colors.white)),
                        Text("1hr:38min", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Release Date", style: TextStyle(color: Colors.white)),
                        Text("21 April 2023", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                20.hs,
                const Text("Available in Languages:", style: TextStyle(color: Colors.white)),
                const Text(" Hindi , English, Telugu", style: TextStyle(color: Colors.white)),
                2.hs,
                const Divider(thickness: 2),
              ],
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.hs,
                  Text("Story Plot", style: TextStyle(color: Colors.white)),
                  10.hs,
                  ExpandableText(text:AppStrings.sampleMoviePlotText*5, style: TextStyle(color: Colors.white)),
                  Divider(thickness: 2.h),
                ],
              ),
            ),
            SizedBox(
              height: 120.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cast", style: TextStyle(color: Colors.white)),
                  5.hs,
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, idx) => 10.ws,
                      itemCount: 5,
                      itemBuilder: (_, idx) {
                        return MovieCard(customHeight: 50, customWidth: 70);
                      },
                    ),
                  ),
                  10.hs,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
