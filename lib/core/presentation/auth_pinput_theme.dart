import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

/// Shared styling for [Pinput] in auth flows (verify email, password recovery, etc.).
const kAuthPinBrandBlue = Color(0xff004CFF);
const kAuthPinFieldBg = Color(0xFFF7F8F9);

PinTheme buildAuthPinTheme({Border? border}) {
  return PinTheme(
    width: 46,
    height: 54,
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color(0xff202020),
    ),
    decoration: BoxDecoration(
      color: kAuthPinFieldBg,
      borderRadius: BorderRadius.circular(16),
      border: border ?? Border.all(color: Colors.transparent, width: 2),
    ),
  );
}
