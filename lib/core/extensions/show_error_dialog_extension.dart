import 'package:flutter/material.dart';

import '../errors/error_model.dart';
import '../utils/app_colors.dart';
import '../widgets/error_dialog.dart';

extension ShowErrorDialogExtension on BuildContext {
  Future<void> showCustomErrorDialog({
    required String title,
    ErrorModel? error,
    bool barrierDismissible = false,
  }) {
    return showGeneralDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: AppColors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, animation1, animation2) => const SizedBox.shrink(),
      transitionBuilder: (context, animation1, animation2, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation1, curve: Curves.easeInOut),
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation1, curve: Curves.easeInOut),
            child: ErrorDialog(
              title: title,
              error: error!,

              onDismiss: () => Navigator.of(context).pop(),
            ),
          ),
        );
      },
    );
  }
}
