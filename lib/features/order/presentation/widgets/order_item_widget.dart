import '../../../../core/widgets/default_app_button.dart';
import '../views/track_order_map_view.dart';

import '../../data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/helpers/order_status_enum.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      color: order.status == getOrderStatusName(OrderStatus.onTheWay)
          ? AppColors.primary
          : order.status == getOrderStatusName(OrderStatus.notStartedYet)
          ? Colors.blueGrey
          : order.status == getOrderStatusName(OrderStatus.rejected)
          ? Colors.red
          : Colors.green,
      borderRadius: BorderRadius.circular(8.r),
    );
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
          Row(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Order Price : ',
                      style: AppStyles.regular22.copyWith(
                        color: AppColors.dark,
                      ),
                    ),
                    TextSpan(
                      text: order.calcTotalPrice().toString(),
                      style: AppStyles.bold24.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: boxDecoration,
                child: Text(
                  order.status,
                  style: AppStyles.medium16.copyWith(color: AppColors.light),
                ),
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Shipping Address : ',
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
                  text: 'Payment Method : ',
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
                  text: 'User Phone : ',
                  style: AppStyles.regular22.copyWith(color: AppColors.dark),
                ),
                TextSpan(
                  text: order.userPhone,
                  style: AppStyles.bold24.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          ...order.coffees.map(
            (coffe) => ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(coffe.img)),
              title: Text(coffe.name),
              subtitle: Text(coffe.price.toString()),
              trailing: Text(coffe.count.toString()),
            ),
          ),
          Visibility(
            visible: order.status != getOrderStatusName(OrderStatus.delivered),
            child: Column(
              children: [
                Gap(16),
                DefaultAppButton(
                  text: 'Track Your Order',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      TrackOrderMapView.routeName,
                      arguments: order,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
