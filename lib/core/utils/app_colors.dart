// App colors configuration
import 'dart:ui';

class AppColors {
  AppColors._({required this.isDark});

  final bool isDark;

  // Light theme colors
  //white
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightPrimary = Color(0xFF004CFF);
  static const Color lightSecondary = Color(0xFF18153F);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightError = Color(0xFFB00020);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFF000000);
  static const Color lightOnSurface = Color(0xFF000000);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color colorBeamFrom = Color(0xFF2962FF);
  static const Color colorBeamTo = Color(0xFFA6D0F5);

  // Neutral colors (same for both themes)
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Accent colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF2196F3);
  static const Color error = Color(0xFFB00020);
}
