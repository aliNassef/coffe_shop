import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/user_orders_view_body.dart';

class UserOrdersView extends StatelessWidget {
  const UserOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Your Order',
          style: TextStyle(color: AppColors.light),
        ),
        automaticallyImplyLeading: false,
      ),
      body: UserOrdersViewBody(),
    );
  }
}
