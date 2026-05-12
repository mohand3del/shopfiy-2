import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final bool isEnabled;

  const CustomGradientButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool canTap = isEnabled && !isLoading;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: canTap ? 1.0 : 0.7,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.colorBeamFrom,
              AppColors.lightPrimary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightPrimary.withValues(alpha:0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: canTap ? onTap : null,
            borderRadius: BorderRadius.circular(16.r),
            child: Center(
              child: isLoading
                  ? LoadingAnimationWidget.discreteCircle(
                      color: Colors.white,
                      size: 30.sp,
                    )
                  : Text(title, style: AppStyles.bold18(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
