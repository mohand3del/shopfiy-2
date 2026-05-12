import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Widget? icon;
  final bool isDanger;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmButtonText,
    required this.onConfirm,
    this.onCancel,
    this.cancelButtonText = "إلغاء",
    this.icon,
    this.isDanger = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: icon != null ? FlipX(child: icon!) : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        _buildCancelButton(context),
        _buildConfirmButton(context, isDanger: isDanger),
      ],
    );
  }

  /// **Cancel Button**
  Widget _buildCancelButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onCancel != null) onCancel!();
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: const Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          cancelButtonText,
          style: AppStyles.bold12(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context, {bool isDanger = true}) {
    return SizedBox(
      width: 100,
      height: 40,
      // child: CustomButton(
      //   color: isDanger ? AppColors.error : AppColors.success,
      //   onPressed: onConfirm,
      //   text: confirmButtonText,
      // ),
    );
  }
}
