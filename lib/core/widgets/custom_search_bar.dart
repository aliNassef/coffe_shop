import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, this.onChanged});
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 22.w,
      children: [
        Expanded(
          child: TextField(
            cursorColor: AppColors.primary,
            textCapitalization:
                TextCapitalization.sentences, // First letter of each sentence

            style: AppStyles.regular20.copyWith(color: AppColors.light),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Search Coffe',
              hintStyle: AppStyles.regular20.copyWith(color: AppColors.gray),
              border: _buildBorderStyle(),
              enabledBorder: _buildBorderStyle(),
              focusedBorder: _buildBorderStyle(),
              fillColor: AppColors.dark,
              filled: true,
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.filter_list_outlined, color: AppColors.light),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.gray, width: 1),
    );
  }
}
