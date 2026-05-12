import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundOverlay extends StatelessWidget {
  const BackgroundOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF5F5F7),
            const Color(0xFFFFFFFF).withValues(alpha: 0.95),
          ],
        ),
      ),
    );
  }
}
