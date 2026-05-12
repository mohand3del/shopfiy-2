import 'package:e_commerce_app/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.06),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmer(height: 145.h, width: double.infinity),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmer(height: 16.h, width: double.infinity),
              Gap( 8.h),
                CustomShimmer(height: 12.h, width: 100.w),
              Gap( 8.h),
                Row(
                  children: [
                    CustomShimmer(height: 12.h, width: 60.w),
                    Gap( 6.w),
                    CustomShimmer(height: 16.h, width: 80.w),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedProductCardShimmer extends StatelessWidget {
  const FeaturedProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.06),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmer(height: 160.h, width: double.infinity),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmer(height: 18.h, width: double.infinity),
              Gap( 8.h),
                CustomShimmer(height: 14.h, width: 120.w),
              Gap( 12.h),
                Row(
                  children: [
                    CustomShimmer(height: 14.h, width: 60.w),
                    Gap( 8.w),
                    CustomShimmer(height: 18.h, width: 80.w),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsGridShimmer extends StatelessWidget {
  final int itemCount;

  const ProductsGridShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.68,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => const ProductCardShimmer(),
        childCount: itemCount,
      ),
    );
  }
}

class FeaturedProductsListShimmer extends StatelessWidget {
  final int itemCount;
  final double height;

  const FeaturedProductsListShimmer({
    super.key,
    this.itemCount = 4,
    this.height = 280.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) => const FeaturedProductCardShimmer(),
      ),
    );
  }
}
