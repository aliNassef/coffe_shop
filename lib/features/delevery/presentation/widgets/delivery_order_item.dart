import 'package:coffe_shop/core/helpers/order_status_enum.dart';
import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'accept_or_reject_order_button.dart';

class DeliveryOrderItem extends StatelessWidget {
  const DeliveryOrderItem({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      color: order.status == getOrderStatusName(OrderStatus.onTheWay)
          ? AppColors.primary
          : order.status == getOrderStatusName(OrderStatus.pending)
          ? Colors.blueGrey
          : order.status == getOrderStatusName(OrderStatus.accepted)
          ? Colors.green
          : Colors.red,
      borderRadius: BorderRadius.circular(8.r),
    );
    return GestureDetector(
      onLongPress: () {
        _makePhoneCall('01552630695');
      },
      child: Container(
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
            Gap(16),
            AcceptorRejectOrderButton(order: order),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
}
