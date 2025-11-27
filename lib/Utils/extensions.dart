import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension IntExtention on int {

  SizedBox get hs {
    final sizedBox = SizedBox(height: h);
    return sizedBox;
  }

  SizedBox get ws {
    final sizedBox = SizedBox(width: w);
    return sizedBox;
  }
}