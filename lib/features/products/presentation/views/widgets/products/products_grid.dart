import 'package:practical_cubit/features/products/domain/entities/product.dart';
import 'package:practical_cubit/features/products/presentation/views/widgets/products/product_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final Function(Product)? onProductTap;

  const ProductsGrid({super.key, required this.products, this.onProductTap});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.65,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () => onProductTap?.call(product),
        );
      }, childCount: products.length),
    );
  }
}
