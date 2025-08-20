import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_network_image.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        CustomNetworkImage(
          height: 80.h,
          width: 120.w,
          radius: 12,
          img:
              'https://images.unsplash.com/photo-1506372023823-741c83b836fe?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Cafe Latte',
              style: AppStyles.medium16.copyWith(fontSize: 18.sp),
            ),
            Text(
              'Deep Foam',
              style: AppStyles.regular14.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
        Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove, size: 24.sp, color: AppColors.dark),
              ),
            ),
            Text('1'),
            IconButton(
              onPressed: () {},
              icon: Container(
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8.w),
                child: Icon(Icons.add, size: 24.sp, color: AppColors.dark),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
