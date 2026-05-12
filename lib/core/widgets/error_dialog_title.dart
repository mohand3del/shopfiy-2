import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class ErrorDialogTitle extends StatelessWidget {
  final String title;

  const ErrorDialogTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppStyles.bold22(color: AppColors.lightSecondary),
      textAlign: TextAlign.center,
    );
  }
}
