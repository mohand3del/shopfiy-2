import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/widgets/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'error_image_holder.dart';

class ProductImageSection extends StatelessWidget {
  final String coverPictureUrl;
  final List<String>? productPictures;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const ProductImageSection({
    super.key,
    required this.coverPictureUrl,
    required this.productPictures,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasGallery = productPictures != null && productPictures!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            buildMainImage(coverPictureUrl, context),
            Positioned(top: 16.h, right: 16.w, child: buildZoomButton(context)),
          ],
        ),
        if (hasGallery) ...[
          Gap(16.h),
          buildCarousel(productPictures!, context),
          Gap(12.h),
          buildIndicator(productPictures!.length, currentIndex),
        ],
      ],
    );
  }

  Widget buildMainImage(String imageUrl, BuildContext context) {
    return GestureDetector(
      onTap: () => showImageZoom(context, imageUrl),
      child: Container(
        width: double.infinity,
        height: 280.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: AppColors.grey100,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Hero(
          tag: imageUrl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  CustomShimmer(height: 280.h, width: double.infinity),
              errorWidget: (context, url, error) => const ErrorImageHolder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildZoomButton(BuildContext context) {
    return InkWell(
      onTap: () => showImageZoom(context, coverPictureUrl),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Icon(CupertinoIcons.zoom_in, color: Colors.white, size: 20.sp),
      ),
    );
  }

  void showImageZoom(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget buildCarousel(List<String> imageUrls, BuildContext context) {
    return CarouselSlider(
      items: imageUrls.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, _) => CustomShimmer(height: 80, width: 80),
            errorWidget: (context, url, error) => const ErrorImageHolder(),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 100.h,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: imageUrls.length > 1,
        onPageChanged: (index, _) => onPageChanged(index),
      ),
    );
  }

  Widget buildIndicator(int length, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    colors: [
                      AppColors.lightSecondary,
                      AppColors.lightSecondary.withValues(alpha: 0.6),
                    ],
                  )
                : null,
            color: isActive ? null : AppColors.grey300,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.lightSecondary.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
        );
      }),
    );
  }
}
