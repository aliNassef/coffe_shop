import 'package:coffe_shop/core/extensions/padding_extension.dart';
import 'package:coffe_shop/core/utils/app_assets.dart';
import 'package:coffe_shop/core/widgets/custom_text_form_field.dart';
import 'package:coffe_shop/core/widgets/default_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'custom_drop_down_menu.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(20),
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage(AppImages.logo),
              radius: 150.r,
            ),
          ),
          const Gap(50),
          CustomTextFormField(
            hintText: 'Email',
            controller: TextEditingController(),
          ),
          const Gap(20),
          CustomTextFormField(
            hintText: 'Password',
            controller: TextEditingController(),
          ),
          const Gap(20),
          CustomDropDownMenu(),
          const Gap(32),
          DefaultAppButton(text: 'Login', onPressed: () {}),
        ],
      ).withHorizontalPadding(16),
    );
  }
}
