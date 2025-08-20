import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoffeDetailsReview extends StatelessWidget {
  const CoffeDetailsReview({
    super.key,
    required this.numOfReviews,
    required this.rating,
  });
  final int numOfReviews;
  final double rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      children: [
        Icon(
          Icons.star,
          color: AppColors.primary.withValues(alpha: .5),
          size: 32,
        ),
        Text(
          rating.toString(),
          style: AppStyles.semiBold24.copyWith(color: AppColors.dark),
        ),
        Text(
          '  ($numOfReviews reviews)',
          style: AppStyles.regular22.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
