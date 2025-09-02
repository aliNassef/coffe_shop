import 'package:coffe_shop/core/extensions/mediaquery_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/user_model.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: controller,
      width: context.width,
      hintText: 'Role',
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 16.w),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      menuStyle: MenuStyle(
        elevation: WidgetStatePropertyAll(0),
        maximumSize: WidgetStatePropertyAll(Size.infinite),
        backgroundColor: WidgetStatePropertyAll(AppColors.light),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(color: AppColors.secondary, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(color: AppColors.secondary, width: 1),
        ),
      ),
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: UserRole.delivery,
          label: 'Delivery',
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(AppStyles.regular22),
            backgroundColor: WidgetStatePropertyAll(AppColors.light),
            elevation: WidgetStatePropertyAll(0),
          ),
        ),
        DropdownMenuEntry(
          value: UserRole.user,
          label: 'Client',
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(AppStyles.regular22),
            backgroundColor: WidgetStatePropertyAll(AppColors.light),
            elevation: WidgetStatePropertyAll(0),
          ),
        ),
      ],
    );
  }
}
