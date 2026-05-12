import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.color = const Color(0x14707070)});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 1, color: color);
  }
}
