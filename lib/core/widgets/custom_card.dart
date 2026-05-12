import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.elevation = 4,
    this.borderRadius = 14,
    this.padding = const EdgeInsets.all(15),
    this.margin,
    this.height,
    this.width,
    this.constraints,
    this.onTap,
  });

  final Widget child;
  final double elevation;
  final double borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: constraints,
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14132C4A), // Shadow color
              offset: Offset(0, 6), // Shadow offset
              blurRadius: 16, // Blur radius
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
