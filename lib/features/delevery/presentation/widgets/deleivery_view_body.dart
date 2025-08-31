import '../../../../core/widgets/custom_failure_widget.dart';
import '../controller/cubit/delivery_cubit.dart';
import '../../../order/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helpers/order_status_enum.dart';
import '../../../home/data/model/coffe_model.dart';
import 'delivery_order_item.dart';

class DelieveryViewBody extends StatelessWidget {
  const DelieveryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryCubit, DeliveryState>(
      buildWhen: (previous, current) =>
          current is DeliveryLoaded ||
          current is DeliveryFailure ||
          current is DeliveryLoading,
      builder: (context, state) {
        if (state is DeliveryLoading) {
          return _buildDeliveryOrderLoading();
        }
        if (state is DeliveryFailure) {
          return CustomFailureWidget(errMessage: state.errMessage);
        }
        if (state is DeliveryLoaded) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemBuilder: (context, index) =>
                DeliveryOrderItem(order: state.orders[index]),
            itemCount: state.orders.length,
            separatorBuilder: (context, index) => Gap(16),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Skeletonizer _buildDeliveryOrderLoading() {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemBuilder: (context, index) => DeliveryOrderItem(
          order: OrderModel(
            orderId: "order_123",
            userId: "user_001",
            userName: "Ali",
            userPhone: "0101234567",
            userLat: 30.0444,
            userLong: 31.2357,
            status: getOrderStatusName(OrderStatus.notStartedYet),
            createdAt: DateTime.now(),
            deliveryId: "d123",
            deliveryName: "Ahmed",
            deliveryPhone: "0109876543",
            deliveryLat: 30.0460,
            deliveryLong: 31.2400,
            coffees: [
              CoffeeModel(
                coffeeId: "latte_1",
                name: "Latte",
                numOfReviews: 4,
                price: 45.0,
                size: "Medium",
                count: 1,
                img:
                    "https://plus.unsplash.com/premium_photo-1673545518947-ddf3240090b1?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                rate: 4.5,
                desc: "Freshly brewed latte with milk",
                type: "Latte",
              ),
            ],
          ),
        ),
        itemCount: 10,
        separatorBuilder: (context, index) => Gap(16),
      ),
    );
  }
}
