import 'package:flutter/material.dart';

class CustomSmallCard extends StatelessWidget {
  const CustomSmallCard({
    super.key,
    this.color = Colors.white,
    required this.child,
    this.margin,
    this.padding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 12,
    ),
    this.shape = BoxShape.rectangle,
    this.height = 50,
    this.width = 50,
  });
  final Color? color;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final BoxShape shape;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      alignment: Alignment.center,
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        shape: shape,
        borderRadius:
            shape == BoxShape.rectangle ? BorderRadius.circular(14) : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14132C4A), // Shadow color
            offset: Offset(0, 6), // Shadow offset
            blurRadius: 16, // Blur radius
          ),
        ],
      ),
      child: child,
    );
  }
}
