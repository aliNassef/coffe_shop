import '../../../home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../order/presentation/views/user_order_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});
  static const routeName = 'layout';

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [HomeView(), UserOrdersView()],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        height: kBottomNavigationBarHeight,
        child: Row(
          children: List.generate(
            2,
            (index) => Expanded(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                icon: Icon(
                  index == 0
                      ? Icons.coffee
                      : Icons.production_quantity_limits_outlined,
                  color: _selectedIndex == index
                      ? AppColors.primary
                      : AppColors.secondary,
                  size: 34.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
