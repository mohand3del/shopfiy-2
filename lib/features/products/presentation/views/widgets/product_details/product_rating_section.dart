import 'package:practical_cubit/core/utils/app_colors.dart';
import 'package:practical_cubit/features/products/presentation/views/widgets/products/product_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRatingSection extends StatelessWidget {
  final int rating;
  final int reviewsCount;

  const ProductRatingSection({
    super.key,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: ProductRatingWidget(
        rating: rating,
        reviewsCount: reviewsCount,
        fontSize: 14.sp,
      ),
    );
  }
}
