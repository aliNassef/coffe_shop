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
      body: const OrderViewBody().withHorizontalPadding(16),
    );
  }
}
