import 'package:coffe_shop/core/di/service_locator.dart';
import 'package:coffe_shop/core/extensions/padding_extension.dart';
import 'package:coffe_shop/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const routeName = 'signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => injector<AuthCubit>(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SignupViewBody().withHorizontalPadding(16),
          ),
        ),
      ),
    );
  }
}
