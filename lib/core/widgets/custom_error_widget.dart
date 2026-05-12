import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.message,
    this.height,
    this.width,
    this.onRetry,
    this.retryTitle,
  });

  final String message;
  final double? height;
  final double? width;
  final VoidCallback? onRetry;
  final String? retryTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 250, // Default height if not provided
      width: width ?? double.infinity, // Default width if not provided
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 50),
          const Gap(16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Gap(20),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(
                retryTitle ?? 'Retry',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
