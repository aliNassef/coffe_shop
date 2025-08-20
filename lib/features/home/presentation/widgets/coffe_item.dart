import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../data/model/coffe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_network_image.dart';

class CoffeItem extends StatelessWidget {
  const CoffeItem({super.key, required this.coffee});
  final CoffeeModel coffee;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomNetworkImage(
                height: 200.h,
                radius: 16.r,
                width: context.width,
                img: coffee.img,
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Row(
                  spacing: 4.w,
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text(
                      coffee.rate.toString(),
                      style: AppStyles.regular20.copyWith(
                        color: AppColors.light,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Gap(8),
          Text(
            coffee.name,
            style: AppStyles.semiBold24.copyWith(color: AppColors.dark),
          ).withHorizontalPadding(16),
          Gap(8),
          Text(
            coffee.type,
            style: AppStyles.regular20.copyWith(color: AppColors.dark),
          ).withHorizontalPadding(16),
          Gap(8),
          Row(
            children: [
              Text(
                '\$${coffee.price}',
                style: AppStyles.bold24.copyWith(color: AppColors.dark),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.add, color: AppColors.light),
              ),
            ],
          ).withHorizontalPadding(16),
        ],
      ),
    );
  }
}
