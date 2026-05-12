import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductRatingWidget extends StatelessWidget {
  final int rating;
  final int reviewsCount;
  final double fontSize;

  const ProductRatingWidget({
    super.key,
    required this.rating,
    required this.reviewsCount,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          CupertinoIcons.star_fill,
          color: const Color(0xFFFFCC00),
          size: fontSize + 1,
        ),
        Gap(4.w),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1D1D1F),
          ),
        ),
        Text(
          ' ($reviewsCount)',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF86868B),
          ),
        ),
      ],
    );
  }
}
