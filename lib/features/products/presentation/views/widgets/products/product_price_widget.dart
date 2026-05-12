import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductPriceWidget extends StatelessWidget {
  final double price;
  final double discountedPrice;
  final double discountPercentage;
  final double originalFontSize;
  final double discountedFontSize;

  const ProductPriceWidget({
    super.key,
    required this.price,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.originalFontSize,
    required this.discountedFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (discountPercentage > 0) ...[
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: originalFontSize,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF86868B),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        Gap(8.w),
        ],
        Text(
          '\$${discountedPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: discountedFontSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF007AFF),
            letterSpacing: -0.4,
          ),
        ),
      ],
    );
  }
}
