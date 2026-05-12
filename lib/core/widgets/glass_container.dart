import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final double borderRadius;
  final double blurSigma;
  final Color backgroundColor;
  final double borderOpacity;
  final double shadowOpacity;
  final double shadowBlurRadius;
  final Offset shadowOffset;
  final Widget child;

  const GlassContainer({
    super.key,
    required this.borderRadius,
    required this.blurSigma,
    required this.backgroundColor,
    required this.borderOpacity,
    required this.shadowOpacity,
    required this.shadowBlurRadius,
    required this.shadowOffset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.black.withValues(alpha: borderOpacity),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: shadowOpacity),
                blurRadius: shadowBlurRadius,
                offset: shadowOffset,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
