import 'dart:developer';

import '../../../../core/extensions/mediaquery_size.dart';
import '../controller/bloc/coffe_search_bloc.dart';
import '../../../order/presentation/controller/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../../../../core/widgets/custom_search_bar.dart';

class LocationAndSearchBarWidget extends StatelessWidget {
  const LocationAndSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: context.height * .3,
      decoration: BoxDecoration(color: AppColors.dark),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: AppStyles.regular20.copyWith(color: AppColors.gray),
            ),
            Gap(8),
            BlocBuilder<UserCubit, UserState>(
              buildWhen: (previous, current) =>
                  current is GetuserLocationLoadedState ||
                  current is GetuserLocationFailed ||
                  current is GetuserLocationLoadingState,
              builder: (context, state) {
                if (state is GetuserLocationLoadingState) {
                  return Skeletonizer(
                    enabled: true,
                    child: Text(
                      'Egypt, Alexandria',
                      style: AppStyles.bold20.copyWith(color: AppColors.light),
                    ),
                  );
                }
                if (state is GetuserLocationFailed) {
                  log('Error: ${state.error}');
                  return CustomFailureWidget(errMessage: state.error);
                }
                if (state is GetuserLocationLoadedState) {
                  return Text(
                    state.address,
                    style: AppStyles.bold20.copyWith(color: AppColors.light),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            Gap(16),
            CustomSearchBar(
              onChanged: (query) {
                context.read<CoffeSearchBloc>().add(
                  CoffeSearchQueryChanged(query),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
