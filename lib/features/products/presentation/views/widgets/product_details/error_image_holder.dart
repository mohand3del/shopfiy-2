import 'package:practical_cubit/core/utils/app_colors.dart';
import 'package:practical_cubit/core/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ErrorImageHolder extends StatelessWidget {
  const ErrorImageHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.photo, size: 64.sp, color: AppColors.grey400),
            Gap(8.h),
            Text(
              'Image not available',
              style: AppStyles.regular14(color: AppColors.grey500),
            ),
          ],
        ),
      ),
    );
  }
}
