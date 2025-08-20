import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/default_app_button.dart';
import '../controller/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widgets/edit_address_or_add_note.dart';
import '../widgets/order_item.dart';
import 'order_type.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({super.key});

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
        BlocBuilder<OrderCubit, OrderState>(
          buildWhen: (previous, current) =>
              current is GetuserLocationFailed ||
              current is GetuserLocationLoaded ||
              current is GetuserLocationLoading ||
              current is UpdateUserAddressState,
          builder: (context, state) {
            if (state is GetuserLocationLoading) {
              return Skeletonizer(
                enabled: true,
                child: Text(
                  'Egypt, Cairo, Nasr City, 12345',
                  style: AppStyles.regular14.copyWith(fontSize: 16.sp),
                ),
              );
            }
            if (state is GetuserLocationLoaded ||
                state is UpdateUserAddressState) {
              return Text(
                state is UpdateUserAddressState
                    ? state.address
                    : (state as GetuserLocationLoaded).address,
                style: AppStyles.regular14.copyWith(fontSize: 16.sp),
              );
            }
            if (state is GetuserLocationFailed) {
              return Text(
                state.error,
                style: AppStyles.regular14.copyWith(
                  fontSize: 16.sp,
                  color: Colors.red,
                ),
              );
            }
            return SizedBox.shrink();
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
        DefaultAppButton(text: 'Order'),
      ],
    );
  }
}
