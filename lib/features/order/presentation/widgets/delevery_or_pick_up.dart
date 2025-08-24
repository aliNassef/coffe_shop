import 'package:coffe_shop/core/extensions/mediaquery_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class DeleveryOrPickUp extends StatelessWidget {
  const DeleveryOrPickUp({
    super.key,
    required this.title,
    required this.isSelected,
  });
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * .44,
      alignment: Alignment.center,
      height: 50.h,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: AppStyles.medium16.copyWith(
          fontSize: 20.sp,
          color: isSelected ? Colors.white : AppColors.dark,
        ),
      ),
    );
  }
}
