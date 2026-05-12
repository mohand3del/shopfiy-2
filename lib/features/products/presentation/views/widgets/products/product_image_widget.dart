import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:practical_cubit/core/widgets/custom_shimmer.dart';
import 'package:practical_cubit/features/products/presentation/views/widgets/products/discount_badge.dart';
import 'package:practical_cubit/features/products/presentation/views/widgets/products/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageWidget extends StatelessWidget {
  final String imageUrl;
  final double discountPercentage;
  final BorderRadius borderRadius;
  final double height;
  final bool showHeartIcon;

  const ProductImageWidget({
    super.key,
    required this.imageUrl,
    required this.discountPercentage,
    required this.borderRadius,
    required this.height,
    this.showHeartIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: imageUrl,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Container(
              height: height,
              width: double.infinity,
              color: const Color(0xFFF5F5F7),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    CustomShimmer(height: height, width: double.infinity),
                errorWidget: (context, url, error) => Container(
                  height: height,
                  width: double.infinity,
                  color: const Color(0xFFF5F5F7),
                  child: Icon(
                    CupertinoIcons.photo,
                    size: showHeartIcon ? 48.sp : 42.sp,
                    color: const Color(0xFF86868B),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (discountPercentage > 0)
          Positioned(
            top: 12.h,
            right: 12.w,
            child: DiscountBadge(discountPercentage: discountPercentage),
          ),
        if (showHeartIcon)
          Positioned(top: 12.h, left: 12.w, child: const FavoriteButton()),
      ],
    );
  }
}
