import 'package:practical_cubit/core/utils/app_colors.dart';
import 'package:practical_cubit/core/utils/app_styles.dart';
import 'package:practical_cubit/features/products/domain/entities/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductDescriptionSection extends StatefulWidget {
  final Product product;

  const ProductDescriptionSection({super.key, required this.product});

  @override
  State<ProductDescriptionSection> createState() =>
      ProductDescriptionSectionState();
}

class ProductDescriptionSectionState extends State<ProductDescriptionSection> {
  bool isExpanded = false;
  static const int maxLines = 3;

  @override
  Widget build(BuildContext context) {
    final needsExpansion = widget.product.description.length > 150;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.doc_text,
                size: 20.sp,
                color: AppColors.lightSecondary,
              ),
              Gap(8.w),
              Text(
                'Description',
                style: AppStyles.bold18(color: AppColors.lightSecondary),
              ),
            ],
          ),
          Gap(12.h),
          AnimatedCrossFade(
            firstChild: Text(
              widget.product.description,
              style: AppStyles.regular16(
                color: AppColors.grey600,
              ).copyWith(height: 1.6),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
            secondChild: Text(
              widget.product.description,
              style: AppStyles.regular16(
                color: AppColors.grey600,
              ).copyWith(height: 1.6),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          if (needsExpansion) ...[
            Gap(8.h),
            GestureDetector(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isExpanded ? 'Show less' : 'Read more',
                    style: AppStyles.bold14(color: AppColors.lightSecondary),
                  ),
                  Gap(4.w),
                  Icon(
                    isExpanded
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                    size: 16.sp,
                    color: AppColors.lightSecondary,
                  ),
                ],
              ),
            ),
          ],
          if (widget.product.arabicDescription.isNotEmpty) ...[
            Gap(20.h),
            Divider(color: AppColors.grey300, thickness: 1),
            Gap(20.h),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'الوصف',
                    textDirection: TextDirection.rtl,
                    style: AppStyles.bold18(
                      color: AppColors.lightSecondary,
                      fontFamily: AppStyles.playpenSansArabicFontFamily,
                    ),
                  ),
                  Gap(8.w),
                  Icon(
                    CupertinoIcons.doc_text,
                    size: 20.sp,
                    color: AppColors.lightSecondary,
                  ),
                ],
              ),
            ),
            Gap(12.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.product.arabicDescription,
                textDirection: TextDirection.rtl,
                style: AppStyles.regular16(
                  color: AppColors.grey600,
                  fontFamily: AppStyles.playpenSansArabicFontFamily,
                ).copyWith(height: 1.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
