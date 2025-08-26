import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/default_app_button.dart';

class DeliveryOrderItem extends StatelessWidget {
  const DeliveryOrderItem({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100.withValues(alpha: 0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Order Id : ',
                  style: AppStyles.regular22.copyWith(color: AppColors.dark),
                ),
                TextSpan(
                  text: order.orderId,
                  style: AppStyles.bold24.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'User Name : ',
                  style: AppStyles.regular22.copyWith(color: AppColors.dark),
                ),
                TextSpan(
                  text: order.userName,
                  style: AppStyles.bold24.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Order Price : ',
                  style: AppStyles.regular22.copyWith(color: AppColors.dark),
                ),
                TextSpan(
                  text: order.calcTotalPrice().toString(),
                  style: AppStyles.bold24.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Order Status : ',
                  style: AppStyles.regular22.copyWith(color: AppColors.dark),
                ),
                TextSpan(
                  text: order.status,
                  style: AppStyles.bold24.copyWith(color: Colors.green),
                ),
              ],
            ),
          ),
          Gap(16),
          Row(
            spacing: 16.w,
            children: [
              Expanded(
                child: DefaultAppButton(
                  text: 'Reject',
                  onPressed: () {},
                  backgroundColor: Colors.red,
                ),
              ),

              Expanded(
                child: DefaultAppButton(
                  text: 'Accept',
                  onPressed: () {},
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
