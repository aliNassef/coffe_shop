import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../controller/cubit/delivery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/deleivery_view_body.dart';

class DelieveryView extends StatelessWidget {
  const DelieveryView({super.key});
  static const routeName = 'delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
        title: const Text('Orders', style: TextStyle(color: AppColors.light)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.light),
        ),
      ),
      body: BlocProvider(
        create: (context) => injector<DeliveryCubit>()..getDeliveryOrrders(),
        child: DelieveryViewBody(),
      ),
    );
  }
}
