import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/default_app_button.dart';
import 'custom_drop_down_menu.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
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
          hintText: 'Name',
          controller: TextEditingController(),
        ),
        const Gap(20),
        CustomTextFormField(
          hintText: 'Phone Number',
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
        DefaultAppButton(text: 'SignUp', onPressed: () {}),
      ],
    );
  }
}
