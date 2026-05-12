import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductNameSection extends StatelessWidget {
  final Product product;

  const ProductNameSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: AppStyles.bold24(
            color: AppColors.lightSecondary,
          ).copyWith(height: 1.3, letterSpacing: 0.3),
        ),
        if (product.arabicName.isNotEmpty) ...[
          Gap(8.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              product.arabicName,
              textDirection: TextDirection.rtl,
              style: AppStyles.bold20(color: AppColors.grey700).copyWith(
                fontFamily: AppStyles.playpenSansArabicFontFamily,
                height: 1.4,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
