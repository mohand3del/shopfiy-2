import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/products/product_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPriceSection extends StatelessWidget {
  final double price;
  final double discountedPrice;
  final double discountPercentage;

  const ProductPriceSection({
    super.key,
    required this.price,
    required this.discountedPrice,
    required this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lightSecondary.withValues(alpha: 0.05),
            AppColors.lightSecondary.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.lightSecondary.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: ProductPriceWidget(
        price: price,
        discountedPrice: discountedPrice,
        discountPercentage: discountPercentage,
        originalFontSize: 16.sp,
        discountedFontSize: 32.sp,
      ),
    );
  }
}
