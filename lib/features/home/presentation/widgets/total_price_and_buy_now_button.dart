import 'package:coffe_shop/features/home/data/model/coffe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/default_app_button.dart';
import '../../../order/presentation/views/order_view.dart';

class TotalPriceAndBuyNowButton extends StatelessWidget {
  const TotalPriceAndBuyNowButton({
    super.key,
    required this.coffe,
    required this.deleveryFee,
  });
  final CoffeeModel coffe;
  final double deleveryFee;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 30.w,
      children: [
        Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: AppStyles.regular22.copyWith(color: Colors.grey),
            ),
            Text(
              '\$${coffe.price.toStringAsFixed(2)}',
              style: AppStyles.semiBold24.copyWith(
                color: AppColors.dark,
                fontSize: 32.sp,
              ),
            ),
          ],
        ),
        Expanded(
          child: DefaultAppButton(
            text: 'Buy Now',
            onPressed: () {
              _goToOrderView(context);
            },
          ),
        ),
      ],
    );
  }

  void _goToOrderView(BuildContext context) {
    Navigator.pushNamed(context, OrderView.routeName, arguments: coffe);
  }
}
