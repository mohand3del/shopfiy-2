import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class ErrorDialogMessage extends StatelessWidget {
  final String? message;
  final List<String>? errors;

  const ErrorDialogMessage({
    super.key,
    this.message,
    this.errors,
  });

  @override
  Widget build(BuildContext context) {
    final allMessages = [
      if (message != null && message!.isNotEmpty) message!,
      if (errors != null && errors!.isNotEmpty) ...errors!,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: allMessages
            .map(
              (msg) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  msg,
                  style: AppStyles.regular14(color: AppColors.grey600),
                  textAlign: TextAlign.center,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
