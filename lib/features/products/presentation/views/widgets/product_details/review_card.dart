import 'package:cached_network_image/cached_network_image.dart';
import 'package:practical_cubit/core/utils/app_colors.dart';
import 'package:practical_cubit/core/utils/app_styles.dart';
import 'package:practical_cubit/features/reviews/domain/entities/review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.black.withValues(alpha: 0.05),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name, rating, and date
          Row(
            children: [
              // User Avatar
              _buildUserAvatar(),

              Gap(12.w),

              // User name and rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: AppStyles.semiBold16(
                        color: AppColors.lightSecondary,
                      ),
                    ),
                    Gap(4.h),
                    _buildStarRating(),
                  ],
                ),
              ),

              // Date
              Text(
                _formatDate(review.createdAt),
                style: AppStyles.regular12(color: AppColors.grey500),
              ),
            ],
          ),

          Gap(12.h),

          // Review Text
          Text(
            review.comment,
            style: AppStyles.regular14(color: AppColors.grey700),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    if (review.userPicture != null && review.userPicture!.isNotEmpty) {
      return Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.grey200,
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: review.userPicture!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.grey200,
              child: Center(
                child: Icon(
                  CupertinoIcons.person_fill,
                  size: 20.sp,
                  color: AppColors.grey500,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.grey200,
              child: Center(
                child: Icon(
                  CupertinoIcons.person_fill,
                  size: 20.sp,
                  color: AppColors.grey500,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Default avatar with initials
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightPrimary.withValues(alpha: 0.1),
      ),
      child: Center(
        child: Text(
          _getInitials(review.userName),
          style: AppStyles.semiBold16(color: AppColors.lightPrimary),
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: List.generate(5, (index) {
        return Padding(
          padding: EdgeInsets.only(right: index < 4 ? 2.w : 0),
          child: Icon(
            index < review.rating ? Icons.star : Icons.star_border,
            size: 14.sp,
            color: index < review.rating
                ? AppColors.warning
                : AppColors.grey300,
          ),
        );
      }),
    );
  }

  String _getInitials(String name) {
    List<String> names = name.trim().split(' ');
    if (names.isEmpty) return 'U';
    if (names.length == 1) return names[0][0].toUpperCase();
    return '${names[0][0]}${names[1][0]}'.toUpperCase();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      // Simple date formatting without intl package
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }
}
