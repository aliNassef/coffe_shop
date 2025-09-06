import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/default_app_button.dart';
import '../../../../core/widgets/show_loading_box.dart';
import '../../../delevery/presentation/view/delievery_view.dart';
import '../../../layout/presentation/views/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/show_error_message.dart';
import '../../data/models/user_model.dart';
import '../controller/auth_cubit/auth_cubit.dart';
import '../views/signup_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
          CustomTextFormField(hintText: 'Email', controller: _emailController),
          const Gap(20),
          CustomTextFormField(
            hintText: 'Password',
            controller: _passwordController,
          ),
          const Gap(20),
          _buildBlocListnerButton(context),
          const Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account?',
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignupView.routeName);
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ],
      ).withHorizontalPadding(16),
    );
  }

  BlocListener<AuthCubit, AuthState> _buildBlocListnerButton(
    BuildContext context,
  ) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          Navigator.pop(context);
          showErrorMessage(context, errMessage: state.message);
        }
        if (state is AuthSuccess) {
          Navigator.pop(context);
          if (state.role == UserRole.delivery) {
            Navigator.pushReplacementNamed(context, DelieveryView.routeName);
          }
          if (state.role == UserRole.user) {
            Navigator.pushReplacementNamed(context, LayoutView.routeName);
          }
        }

        if (state is AuthLoading) {
          showLoadingBox(context);
        }
      },
      child: DefaultAppButton(
        text: 'Login',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<AuthCubit>().login(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
          }
        },
      ),
    );
  }
}
