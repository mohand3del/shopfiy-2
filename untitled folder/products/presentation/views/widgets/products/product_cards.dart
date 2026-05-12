import 'package:e_commerce_app/core/widgets/glass_container.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/products/product_image_widget.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/products/product_price_widget.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/products/product_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 18.r,
        blurSigma: 10,
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        borderOpacity: 0.06,
        shadowOpacity: 0.06,
        shadowBlurRadius: 16,
        shadowOffset: const Offset(0, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageWidget(
              imageUrl: product.coverPictureUrl,
              discountPercentage: product.discountPercentage,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              height: 160.h,
              showHeartIcon: true,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1D1D1F),
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(4.h),
                    ProductRatingWidget(
                      rating: product.rating,
                      reviewsCount: product.reviewsCount,
                      fontSize: 13.sp,
                    ),
                    const Spacer(),
                    ProductPriceWidget(
                      price: product.price,
                      discountedPrice: discountedPrice,
                      discountPercentage: product.discountPercentage,
                      originalFontSize: 13.sp,
                      discountedFontSize: 18.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const FeaturedProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 18.r,
        blurSigma: 10,
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        borderOpacity: 0.06,
        shadowOpacity: 0.06,
        shadowBlurRadius: 16,
        shadowOffset: const Offset(0, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageWidget(
              imageUrl: product.coverPictureUrl,
              discountPercentage: product.discountPercentage,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              height: 160.h,
              showHeartIcon: true,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1D1D1F),
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(4.h),
                    ProductRatingWidget(
                      rating: product.rating,
                      reviewsCount: product.reviewsCount,
                      fontSize: 13.sp,
                    ),
                    Gap(4.h),

                    ProductPriceWidget(
                      price: product.price,
                      discountedPrice: discountedPrice,
                      discountPercentage: product.discountPercentage,
                      originalFontSize: 13.sp,
                      discountedFontSize: 18.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
