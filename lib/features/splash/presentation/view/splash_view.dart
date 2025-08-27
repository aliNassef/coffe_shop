import '../../../layout/presentation/views/layout_view.dart';

import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/default_app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
              DefaultAppButton(
                text: 'Get Started',
                onPressed: () {
                  _goToHomeScreen(context);
                },
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
}
