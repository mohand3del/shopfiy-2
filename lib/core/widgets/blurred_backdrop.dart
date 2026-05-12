import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredBackdrop extends StatelessWidget {
  const BlurredBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
          child: Container(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
    );
  }
}
//! to use     body: Stack(
//           children: [
//             const BackgroundOverlay(),
//             const BlurImagesOverlay(),
//             const BackdropBlur(),