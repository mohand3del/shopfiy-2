import 'package:flutter/material.dart';

/// Floating, rounded snack bars used across auth and recovery flows.
abstract final class AppSnackBar {
  static const _radius = 14.0;
  static const _brandBlue = Color(0xff004CFF);

  static void success(BuildContext context, String message) {
    _show(
      context,
      message: message,
      icon: Icons.check_circle_rounded,
      background: const Color(0xFF0D47A1),
      iconBackground: Colors.white24,
    );
  }

  static void error(BuildContext context, String message) {
    _show(
      context,
      message: message,
      icon: Icons.error_outline_rounded,
      background: const Color(0xFFC62828),
      iconBackground: Colors.white24,
    );
  }

  static void info(BuildContext context, String message) {
    _show(
      context,
      message: message,
      icon: Icons.mark_email_read_outlined,
      background: _brandBlue,
      iconBackground: Colors.white24,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color background,
    required Color iconBackground,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(_radius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(icon, color: Colors.white, size: 22),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
