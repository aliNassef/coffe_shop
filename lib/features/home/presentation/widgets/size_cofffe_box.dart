import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeCoffeBox extends StatelessWidget {
  const SizeCoffeBox({super.key, required this.text, required this.isSelected});
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: context.width * .2,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.light,
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: AppStyles.medium16.copyWith(
          color: isSelected ? AppColors.primary : AppColors.dark,
          fontSize: 26.sp,
        ),
      ),
    );
  }
}
