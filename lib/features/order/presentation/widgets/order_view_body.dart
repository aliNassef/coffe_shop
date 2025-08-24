import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/helpers/toast_dialog.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/default_app_button.dart';
import '../controller/order_cubit/order_cubit.dart';
import '../controller/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widgets/edit_address_or_add_note.dart';
import '../widgets/order_item.dart';
import 'order_type.dart';

class OrderViewBody extends StatefulWidget {
  const OrderViewBody({super.key});

  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserCoardinate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(20),
        Container(
          height: 60.h,
          width: context.width,
          decoration: BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: OrderType(),
        ),
        Gap(20),
        Text(
          'Delevery Address',
          style: AppStyles.medium16.copyWith(fontSize: 24.sp),
        ),
        Gap(10),
        BlocBuilder<UserCubit, UserState>(
          buildWhen: (previous, current) =>
              current is GetuserLocationFailed ||
              current is GetuserLocationLoadedState ||
              current is GetuserLocationLoadingState ||
              current is UpdateUserAddressState,
          builder: (context, state) => switch (state) {
            GetuserLocationLoadingState() => Skeletonizer(
              enabled: true,
              child: Text(
                'Egypt, Cairo, Nasr City, 12345',
                style: AppStyles.regular14.copyWith(fontSize: 16.sp),
              ),
            ),
            GetuserLocationLoadedState(address: final address) ||
            UpdateUserAddressState(address: final address) => Text(
              address,
              style: AppStyles.regular14.copyWith(fontSize: 16.sp),
            ),
            GetuserLocationFailed(error: final error) => Text(
              error,
              style: AppStyles.regular14.copyWith(
                fontSize: 16.sp,
                color: Colors.red,
              ),
            ),
            _ => const SizedBox.shrink(),
          },
        ),
        Gap(20),
        EditAddressOrAddNote(),
        Gap(16),
        Divider(color: Colors.grey, indent: 30.w, endIndent: 30.w),
        Gap(16),
        OrderItem(),
        Gap(16),
        Text('Payment Summary', style: AppStyles.bold24),
        Gap(16),
        Row(
          children: [
            Text(
              'Price',
              style: AppStyles.regular20.copyWith(color: AppColors.dark),
            ),
            Spacer(),
            Text('\$5.00', style: AppStyles.bold20),
          ],
        ),
        Gap(16),
        Row(
          children: [
            Text(
              'Delivery Fee',
              style: AppStyles.regular20.copyWith(color: AppColors.dark),
            ),
            Spacer(),
            Text('\$5.00', style: AppStyles.bold20),
          ],
        ),
        Gap(22),
        Divider(color: Colors.grey, indent: 30.w, endIndent: 30.w),
        Gap(16),
        Row(
          children: [
            Text(
              'Total',
              style: AppStyles.bold20.copyWith(color: AppColors.dark),
            ),
            Spacer(),
            Text('\$10.00', style: AppStyles.bold24),
          ],
        ),
        Gap(30),
        _addOrderButton(),
      ],
    );
  }

  BlocBuilder<OrderCubit, OrderState> _addOrderButton() {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (previous, current) =>
          current is AddorderLoading ||
          current is AddorderFailed ||
          current is AddorderSuccess,
      builder: (context, state) {
        if (state is AddorderSuccess) {
          showToast(text: 'Order added successfully');
        }
        return BlocSelector<UserCubit, UserState, Position?>(
          selector: (userState) {
            if (userState is GetuserPositonLoadedState) {
              return userState.position;
            }
            return null;
          },
          builder: (context, userPosition) {
            return DefaultAppButton(
              text: state is AddorderLoading ? 'Loading...' : 'Order',
              onPressed: userPosition == null
                  ? null
                  : () {
                      var order = OrderModel(
                        orderId: '1',
                        userId: '1',
                        userName: 'Ali Nassef',
                        userPhone: '01552630695',
                        userLat: userPosition.latitude,
                        userLong: userPosition.longitude,
                        status: 'Pending',
                        createdAt: DateTime.now(),
                        deliveryId: '1',
                        deliveryName: 'Ahmed',
                        deliveryPhone: '01128861472',
                        deliveryLat: 1111,
                        deliveryLong: 11111,
                        coffees: [],
                      );
                      context.read<OrderCubit>().addOrder(order);
                    },
            );
          },
        );
      },
    );
  }
}
