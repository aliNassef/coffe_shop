import 'package:coffe_shop/core/di/service_locator.dart';
import 'package:coffe_shop/features/order/presentation/controller/order_cubit/order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/padding_extension.dart';
import 'package:flutter/material.dart';

import '../widgets/order_view_body.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});
  static const routeName = 'order_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => injector<OrderCubit>(),
        child: const OrderViewBody(),
      ).withHorizontalPadding(16),
    );
  }
}
