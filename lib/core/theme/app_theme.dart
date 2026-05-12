import 'package:practical_cubit/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._(); // Private constructor for static class

  // Light Theme
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.lightPrimary.withValues(alpha: 0.1),
      selectionColor: AppColors.lightPrimary.withValues(alpha: 0.1),
      selectionHandleColor: AppColors.lightPrimary.withValues(alpha: 0.5),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
      ),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.lightPrimary.withValues(alpha: 0.3),
      selectionColor: AppColors.lightPrimary.withValues(alpha: 0.3),
      selectionHandleColor: AppColors.lightPrimary.withValues(alpha: 0.7),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
      ),
    ),
  );

  // Helper: Get theme based on Brightness
  static ThemeData getTheme(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return dark;
      case Brightness.light:
        return light;
    }
  }

  // Enum for theme modes (optional, for Provider/Riverpod/Bloc)
  static const ThemeMode lightMode = ThemeMode.light;
  static const ThemeMode darkMode = ThemeMode.dark;
  static const ThemeMode systemMode = ThemeMode.system;
}
