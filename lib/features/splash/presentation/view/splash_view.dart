import 'dart:developer';

import 'package:coffe_shop/core/widgets/show_loading_box.dart';
import 'package:coffe_shop/features/auth/data/models/user_model.dart';
import 'package:coffe_shop/features/auth/presentation/views/login_view.dart';
import 'package:coffe_shop/features/delevery/presentation/view/delievery_view.dart';
import 'package:coffe_shop/features/order/presentation/controller/user_cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/default_app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../layout/presentation/views/layout_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static const String routeName = 'splash_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.onBoardingImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(context.height * .75),
              Text(
                'Fall in love with coffee in Blissful Delight!',
                style: AppStyles.bold24.copyWith(color: AppColors.light),
                textAlign: TextAlign.center,
              ),
              Gap(14),
              Text(
                'Welcome to our cozy coffe corner, where every cup is a delightful for you.',
                style: AppStyles.regular20.copyWith(color: AppColors.gray),
                textAlign: TextAlign.center,
              ),
              Gap(24),
              BlocListener<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is GetUserLoaded) {
                    Navigator.pop(context);
                    log(state.user!.role.toString());
                    if (state.user == null) _goToLoginScreen(context);

                    if (state.user!.role == UserRole.delivery) {
                      _goToDeliveryScreen(context);
                    } else if (state.user!.role == UserRole.user) {
                      _goToHomeScreen(context);
                    }
                  }
                  if (state is GetUserFailed) {
                    Navigator.pop(context);
                    _goToLoginScreen(context);
                  }

                  if (state is GetUserLoading) {
                    showLoadingBox(context);
                  }
                },
                child: DefaultAppButton(
                  text: 'Get Started',
                  onPressed: () {
                    final userId = context.read<UserCubit>().getUserId();
                    context.read<UserCubit>().getUserById(userId);
                  },
                ),
              ),
            ],
          ).withHorizontalPadding(16),
        ),
      ),
    );
  }

  void _goToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, LayoutView.routeName);
  }

  void _goToDeliveryScreen(BuildContext context) {
    Navigator.pushNamed(context, DelieveryView.routeName);
  }

  void _goToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginView.routeName);
  }
}
