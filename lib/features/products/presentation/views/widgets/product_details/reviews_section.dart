import 'package:practical_cubit/core/cubit/async_state.dart';
import 'package:practical_cubit/core/di/service_locator.dart';
import 'package:practical_cubit/core/utils/app_colors.dart';
import 'package:practical_cubit/core/utils/app_styles.dart';
import 'package:practical_cubit/core/widgets/custom_shimmer.dart';
import 'package:practical_cubit/features/products/presentation/views/widgets/product_details/review_card.dart';
import 'package:practical_cubit/features/reviews/domain/entities/review.dart';
import 'package:practical_cubit/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReviewsSection extends StatelessWidget {
  final String productId;

  const ReviewsSection({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.black.withValues(alpha: 0.06),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Text(
            'Customer Reviews',
            style: AppStyles.bold20(color: AppColors.lightSecondary),
          ),

          Gap(20.h),

          // Reviews List
          BlocBuilder<ReviewsCubit, AsyncState<List<Review>>>(
            builder: (context, state) {
              return state.when(
                initial: () => _buildShimmerList(),
                loading: () => _buildShimmerList(),
                success: (List<Review> reviews) {
                  if (reviews.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildReviewsList(reviews);
                },
                failure: (failure) => _buildErrorState(failure.message),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index < 2 ? 16.h : 0),
          child: _buildReviewCardShimmer(),
        ),
      ),
    );
  }

  Widget _buildReviewCardShimmer() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomShimmer(height: 16.h, width: 120.w),
              const Spacer(),
              CustomShimmer(height: 16.h, width: 80.w),
            ],
          ),
          Gap(8.h),
          CustomShimmer(height: 14.h, width: double.infinity),
          Gap(6.h),
          CustomShimmer(height: 14.h, width: 200.w),
          Gap(12.h),
          CustomShimmer(height: 12.h, width: 100.w),
        ],
      ),
    );
  }

  Widget _buildReviewsList(List<Review> reviews) {
    return Column(
      children: reviews.asMap().entries.map((entry) {
        final index = entry.key;
        final review = entry.value;
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < reviews.length - 1 ? 16.h : 0,
          ),
          child: ReviewCard(review: review),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        children: [
          Icon(
            CupertinoIcons.chat_bubble_text,
            size: 48.sp,
            color: AppColors.grey500,
          ),
          Gap(16.h),
          Text(
            'No Reviews Yet',
            style: AppStyles.semiBold18(color: AppColors.lightSecondary),
          ),
          Gap(8.h),
          Text(
            'Be the first to share your thoughts\nabout this product',
            textAlign: TextAlign.center,
            style: AppStyles.regular14(color: AppColors.grey500),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        children: [
          Icon(
            CupertinoIcons.exclamationmark_triangle,
            size: 48.sp,
            color: AppColors.error,
          ),
          Gap(16.h),
          Text(
            'Failed to Load Reviews',
            style: AppStyles.semiBold18(color: AppColors.lightSecondary),
          ),
          Gap(8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppStyles.regular14(color: AppColors.grey500),
          ),
          Gap(20.h),
          TextButton(
            onPressed: () {
              getIt<ReviewsCubit>().fetchProductReviews(productId!);
            },
            child: Text(
              'Try Again',
              style: AppStyles.semiBold16(color: AppColors.lightPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
