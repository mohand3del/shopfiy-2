// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// import '../utils/app_colors.dart';
// import '../utils/app_styles.dart';
// import 'custom_image.dart';

// class CustomButton extends ConsumerWidget {
//   final String? text;
//   final VoidCallback onPressed;
//   final Color? color;
//   final Color? textColor;
//   final bool isOutlined;
//   final String? iconPath;
//   final double? width;
//   final double height;
//   final double borderRadius;
//   final EdgeInsets padding;
//   //isLoading
//   final bool isLoading;
//   const CustomButton({
//     super.key,
//     this.text,
//     required this.onPressed,
//     this.color,
//     this.textColor,
//     this.isOutlined = false,
//     this.iconPath, // Changed from icon
//     this.width,
//     this.height = 30,
//     this.padding = const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
//     this.borderRadius = 8,
//     this.isLoading = false,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final appColors = ref.colors;
//     return GestureDetector(
//       onTap: isLoading ? null : onPressed,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeInOut,
//         padding: padding,
//         width: width,
//         height: height,
//         decoration: isOutlined
//             ? BoxDecoration(
//                 border: Border.all(color: AppColors.darkPrimary),
//                 color: Theme.of(context).colorScheme.surface,
//                 borderRadius: BorderRadius.circular(borderRadius),
//               )
//             : BoxDecoration(
//                 color: isLoading ? Colors.grey : color ?? Theme.of(context).colorScheme.primary,
//                 borderRadius: BorderRadius.circular(borderRadius),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.1),
//                     spreadRadius: 1,
//                     blurRadius: 6,
//                     offset: const Offset(0, 3), // changes position of shadow
//                   ),
//                 ],
//               ),

//         child: _buildButtonContent(context, isLoading: isLoading),
//       ),
//     );
//   }

//   Widget _buildButtonContent(BuildContext context, {bool isLoading = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         if (iconPath != null) ...[
//           CustomImage(iconPath!, width: 20, height: 20),
//         ],
//         if (text != null)
//           isLoading
//               ? LoadingAnimationWidget.threeArchedCircle(
//                   color: Colors.white,
//                   size: 25,
//                 )
//               : Text(
//                   text!,
//                   textAlign: TextAlign.center,
//                   style: AppStyles.semiBold16(
//                     context,
//                   ).copyWith(color: textColor ?? AppColors.white),
//                 ),
//       ],
//     );
//   }
// }
