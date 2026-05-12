import 'package:practical_cubit/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'product_description_section.dart';
import 'product_discount_badge.dart';
import 'product_image_section.dart';
import 'product_name_section.dart';
import 'product_price_section.dart';
import 'product_rating_section.dart';

class ProductHeader extends StatefulWidget {
  final Product product;

  const ProductHeader({super.key, required this.product});

  @override
  State<ProductHeader> createState() => ProductHeaderState();
}

class ProductHeaderState extends State<ProductHeader> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImageSection(
          coverPictureUrl: product.coverPictureUrl,
          productPictures: product.productPictures,
          currentIndex: currentImageIndex,
          onPageChanged: (index) => setState(() => currentImageIndex = index),
        ),
        Gap(28.h),
        buildProductInfo(product, discountedPrice),
      ],
    );
  }

  Widget buildProductInfo(Product product, double discountedPrice) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductNameSection(product: product),
          Gap(12.h),
          Row(
            children: [
              ProductRatingSection(
                rating: product.rating,
                reviewsCount: product.reviewsCount,
              ),
              const Spacer(),
              if (product.discountPercentage > 0)
                ProductDiscountBadge(discount: product.discountPercentage),
            ],
          ),
          Gap(20.h),
          ProductPriceSection(
            price: product.price,
            discountedPrice: discountedPrice,
            discountPercentage: product.discountPercentage,
          ),
          Gap(28.h),
          ProductDescriptionSection(product: product),
        ],
      ),
    );
  }
}
