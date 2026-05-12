import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static const interFontFamily = 'Inter';
  static const ralewayFontFamily = 'Raleway';
  static const playpenSansArabicFontFamily = 'PlaypenSansArabic';
  // =====================
  // Base Private Methods
  // =====================

  static TextStyle _regular({
    Color color = Colors.white,
    required double fontSize,
    String fontFamily = AppStyles.ralewayFontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      color: color,
      fontSize: fontSize.sp,
    );
  }

  static TextStyle _medium({
    Color color = Colors.white,
    required double fontSize,
    String fontFamily = ralewayFontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      color: color,
      fontSize: fontSize.sp,
    );
  }

  static TextStyle _semiBold({
    Color color = Colors.white,
    required double fontSize,
    String fontFamily = ralewayFontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      color: color,
      fontSize: fontSize.sp,
    );
  }

  static TextStyle _bold({
    Color color = Colors.white,
    required double fontSize,
    String fontFamily = ralewayFontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      color: color,
      fontSize: fontSize.sp,
    );
  }

  static TextStyle _black({
    Color color = Colors.white,
    required double fontSize,
    String fontFamily = ralewayFontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w900,
      color: color,
      fontSize: fontSize.sp,
    );
  }

  // !=====================
  // !Regular
  // !=====================

  static TextStyle regular12({Color? color}) =>
      _regular(color: color ?? Colors.white, fontSize: 12);
  //13
  static TextStyle regular13({Color? color}) =>
      _regular(color: color ?? Colors.white, fontSize: 13);
  static TextStyle regular14({Color? color}) =>
      _regular(color: color ?? Colors.white, fontSize: 14);

  static TextStyle regular16({Color? color, String? fontFamily}) => _regular(
    color: color ?? Colors.white,
    fontSize: 16,
    fontFamily: fontFamily ?? ralewayFontFamily,
  );

  static TextStyle regular18({Color? color}) =>
      _regular(color: color ?? Colors.white, fontSize: 18);

  static TextStyle regular20({Color? color}) =>
      _regular(color: color ?? Colors.white, fontSize: 20);

  static TextStyle regular24({Color? color}) =>
      _regular(color: color ?? Colors.white, fontSize: 24);

  // *=====================
  // *Medium
  // *=====================
  //11
  static TextStyle medium11({Color? color}) =>
      _medium(color: color ?? Colors.white, fontSize: 11);
  // Category 12 (Raleway, w500, grey)
  static TextStyle medium12({Color? color}) {
    return _medium(color: color ?? const Color(0xFFA9A9A9), fontSize: 12);
  }

  static TextStyle medium14({Color? color}) =>
      _medium(color: color ?? Colors.white, fontSize: 14);

  static TextStyle medium16({Color? color}) =>
      _medium(color: color ?? Colors.white, fontSize: 16);

  static TextStyle medium18({Color? color}) =>
      _medium(color: color ?? Colors.white, fontSize: 18);

  static TextStyle medium20({Color? color}) =>
      _medium(color: color ?? Colors.white, fontSize: 20);

  static TextStyle medium24({Color? color}) =>
      _medium(color: color ?? Colors.white, fontSize: 24);

  // *=====================
  // *SemiBold
  // *=====================

  static TextStyle semiBold12({Color? color}) =>
      _semiBold(color: color ?? Colors.white, fontSize: 12);

  static TextStyle semiBold14({Color? color}) =>
      _semiBold(color: color ?? const Color(0xFFA9A9A9), fontSize: 14);

  // Character name 16 (Raleway, w600, dark)
  static TextStyle semiBold16({Color? color}) {
    return _semiBold(color: color ?? const Color(0xFF18153F), fontSize: 16);
  }

  static TextStyle semiBold18({Color? color}) =>
      _semiBold(color: color ?? Colors.white, fontSize: 18);

  static TextStyle semiBold20({Color? color}) =>
      _semiBold(color: color ?? Colors.white, fontSize: 20);

  static TextStyle semiBold24({Color? color}) =>
      _semiBold(color: color ?? Colors.white, fontSize: 24);

  // !=====================
  // !Bold
  // !=====================

  static TextStyle bold12({Color? color}) =>
      _bold(color: color ?? Colors.white, fontSize: 12);

  // "All" button 14 (Raleway, w700, white)
  static TextStyle bold14({Color? color}) {
    return _bold(color: color ?? Colors.white, fontSize: 14);
  }

  // Anime name 14 (Raleway, w700, dark)
  static TextStyle bold14Dark({Color? color}) {
    return _bold(color: color ?? const Color(0xFF18153F), fontSize: 14);
  }

  static TextStyle bold16({Color? color}) =>
      _bold(color: color ?? Colors.white, fontSize: 16);

  static TextStyle bold18({Color? color, String? fontFamily}) => _bold(
    color: color ?? Colors.white,
    fontSize: 18,
    fontFamily: fontFamily ?? ralewayFontFamily,
  );

  static TextStyle bold20({Color? color}) =>
      _bold(color: color ?? Colors.white, fontSize: 20);

  static TextStyle bold22({Color? color}) =>
      _bold(color: color ?? Colors.white, fontSize: 22);

  // Bold 24 (Raleway, w700, dark)
  static TextStyle bold24({Color? color, String? fontFamily}) {
    return _bold(
      color: color ?? const Color(0xFF18153F),
      fontSize: 24,
      fontFamily: fontFamily ?? ralewayFontFamily,
    );
  }

  static TextStyle bold34({Color? color}) =>
      _bold(color: color ?? Colors.white, fontSize: 34);
  //52
  static TextStyle bold52({Color? color}) =>
      _bold(color: color ?? Colors.white, fontSize: 52);
  //54
  static TextStyle bold54({Color? color}) =>
      _bold(color: color ?? Colors.white, fontSize: 54);

  // ?=====================
  // ?Black
  // ?=====================

  static TextStyle black14({Color? color}) =>
      _black(color: color ?? Colors.white, fontSize: 14);

  static TextStyle black16({Color? color}) =>
      _black(color: color ?? Colors.white, fontSize: 16);

  static TextStyle black18({Color? color}) =>
      _black(color: color ?? Colors.white, fontSize: 18);

  static TextStyle black20({Color? color}) =>
      _black(color: color ?? Colors.white, fontSize: 20);

  static TextStyle black24({Color? color}) =>
      _black(color: color ?? Colors.white, fontSize: 24);

  static TextStyle black30({Color? color}) =>
      _black(color: color ?? Colors.white, fontSize: 30);

  static TextStyle black34({Color? color}) =>
      _black(color: color ?? Colors.white, fontSize: 34);
}
