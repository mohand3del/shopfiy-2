import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_styles.dart';

class CustomBlurButton extends StatelessWidget {
  const CustomBlurButton({
    super.key,
    required this.onPressed,
    this.text,
    this.isLoading = false,
    this.height = 30,
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
    this.borderRadius = 8,
    this.fontSize,
    this.child,
    this.image,
  });

  final VoidCallback? onPressed;
  final String? text;
  final bool isLoading;
  final double height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double? fontSize;
  final Widget? child;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: height,
            width: width,
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.2,
              ),
            ),
            alignment: Alignment.center,
            child: isLoading
                ? LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.white,
                    size: 25,
                  )
                : text != null
                ? Text(
                    text!,
                    style: AppStyles.semiBold14(
                      color: Colors.white,
                    ).copyWith(fontSize: fontSize),
                  )
                : child,
          ),
        ),
      ),
    );
  }

  // MARK: - CustomBlurButton
}
