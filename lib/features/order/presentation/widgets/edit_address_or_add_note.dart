import 'dart:developer';

import '../controller/user_cubit/user_cubit.dart';
import '../views/pick_address_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class EditAddressOrAddNote extends StatelessWidget {
  const EditAddressOrAddNote({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        GestureDetector(
          onTap: () async {
            final address =
                await Navigator.pushNamed(context, PickAddressView.routeName)
                    as String?;

            log(address ?? 'No address selected');

            if (address != null && context.mounted) {
              context.read<UserCubit>().updateUserAddress(address);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.edit_note_rounded,
                  color: AppColors.dark,
                  size: 28.sp,
                ),
                Gap(10),
                Text(
                  'Edit Address',
                  style: AppStyles.medium16.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.dark,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.note_alt_outlined,
                  color: AppColors.dark,
                  size: 28.sp,
                ),
                Gap(10),
                Text(
                  'Add Note',
                  style: AppStyles.medium16.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.dark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
