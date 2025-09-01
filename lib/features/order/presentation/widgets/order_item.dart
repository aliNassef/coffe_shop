import '../../../home/data/model/coffe_model.dart';
import '../controller/order_cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_network_image.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({super.key, required this.coffe});
  final CoffeeModel coffe;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        CustomNetworkImage(
          height: 80.h,
          width: 120.w,
          radius: 12,
          img: widget.coffe.img,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.coffe.name,
              style: AppStyles.medium16.copyWith(fontSize: 18.sp),
            ),
            Text(
              widget.coffe.type,
              style: AppStyles.regular14.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
        Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (count > 1) {
                  setState(() {
                    count--;
                  });
                  context.read<OrderCubit>().changeOrderCount(count);
                }
              },
              icon: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove, size: 24.sp, color: AppColors.dark),
              ),
            ),
            Text(count.toString()),
            IconButton(
              onPressed: () {
                setState(() {
                  count++;
                });
                context.read<OrderCubit>().changeOrderCount(count);
              },
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
