import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class ErrorDialogActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ErrorDialogActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightPrimary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              shadowColor: AppColors.lightPrimary.withValues(alpha: 0.3),
            ).copyWith(
              overlayColor: WidgetStateProperty.all(
                AppColors.white.withValues(alpha: 0.1),
              ),
            ),
        child: Text(
          'Try Again',
          style: AppStyles.semiBold16(color: AppColors.white),
        ),
      ),
    );
  }
}
