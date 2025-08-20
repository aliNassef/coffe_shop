import 'dart:developer';

import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/read_more_text.dart';
import '../../data/model/coffe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../widgets/coffe_boxes_size.dart';
import '../widgets/coffe_details_review.dart';
import '../widgets/total_price_and_buy_now_button.dart';

class CoffeDetailsView extends StatelessWidget {
  final CoffeeModel coffe;
  const CoffeDetailsView({super.key, required this.coffe});
  static const routeName = 'coffe_details_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Coffee Details'),
        actions: [
          Icon(
            Icons.favorite_rounded,
            color: AppColors.primary,
            size: 32,
          ).withHorizontalPadding(16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(16),
            CustomNetworkImage(
              radius: 16,
              img: coffe.img,
              height: 200,
              width: context.width,
            ),
            Gap(24),
            Text(
              coffe.name,
              style: AppStyles.semiBold24.copyWith(
                color: AppColors.dark,
                fontSize: 32.sp,
              ),
            ),
            Row(
              spacing: 16.w,
              children: [
                Text(
                  'ice/hot',
                  style: AppStyles.regular22.copyWith(color: Colors.grey),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.gray.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.delivery_dining_outlined,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.gray.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.coffee_outlined,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.gray.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.coffee_maker,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
              ],
            ),
            Gap(16),
            CoffeDetailsReview(
              numOfReviews: coffe.numOfReviews,
              rating: coffe.rate,
            ),
            Divider(indent: 30.w, endIndent: 30.w),
            Gap(20),
            Text(
              'Description',
              style: AppStyles.semiBold24.copyWith(color: AppColors.dark),
            ),
            Gap(16),
            ReadMoreText(text: coffe.desc, maxLines: 3),
            Gap(20),
            Text(
              'Size',
              style: AppStyles.semiBold24.copyWith(color: AppColors.dark),
            ),
            Gap(16),
            CoffeBoxesSize(
              onSizeSelected: (coffeSize) {
                log('Selected size: $coffeSize');
              },
            ),
            Gap(32),
            TotalPriceAndBuyNowButton(price: coffe.price, deleveryFee: 3),
            Gap(30),
          ],
        ).withHorizontalPadding(16),
      ),
    );
  }
}
