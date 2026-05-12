import 'package:practical_cubit/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BlurImagesOverlay extends StatelessWidget {
  const BlurImagesOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.51,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                AppImages.imagesVerifyEmailTop2,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                AppImages.imagesVerifyEmailTop,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
