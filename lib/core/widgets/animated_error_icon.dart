import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AnimatedErrorIcon extends StatelessWidget {
  final Animation<double> animation;
  final IconData iconData;
  const AnimatedErrorIcon({super.key, required this.animation, this.iconData = Icons.error_outline});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.error.withValues(alpha: 0.1),
                  AppColors.error.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                color: AppColors.error.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child:  Icon(iconData, color: AppColors.error, size: 36),
          ),
        );
      },
    );
  }
}
