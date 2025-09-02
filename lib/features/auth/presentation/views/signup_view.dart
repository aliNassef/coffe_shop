import 'package:coffe_shop/core/extensions/padding_extension.dart';
import 'package:flutter/material.dart';

import '../widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const routeName = 'signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SignupViewBody().withHorizontalPadding(16),
        ),
      ),
    );
  }
}
