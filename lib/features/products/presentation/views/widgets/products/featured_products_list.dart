import 'package:practical_cubit/features/products/domain/entities/product.dart';
import 'package:practical_cubit/features/products/presentation/views/widgets/products/product_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedProductsList extends StatelessWidget {
  final List<Product> products;
  final Function(Product)? onProductTap;
  final double height;

  const FeaturedProductsList({
    super.key,
    required this.products,
    this.onProductTap,
    this.height = 265.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          final product = products[index];
          return SizedBox(
            width: 200.w,
            child: FeaturedProductCard(
              product: product,
              onTap: () => onProductTap?.call(product),
            ),
          );
        },
      ),
    );
  }
}
