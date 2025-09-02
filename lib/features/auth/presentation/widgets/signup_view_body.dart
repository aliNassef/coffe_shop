import 'package:coffe_shop/core/widgets/show_error_message.dart';
import 'package:coffe_shop/core/widgets/show_loading_box.dart';
import 'package:coffe_shop/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/default_app_button.dart';
import '../../data/models/user_model.dart';
import '../views/login_view.dart';
import 'custom_drop_down_menu.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _roleController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _roleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Gap(20),
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage(AppImages.logo),
              radius: 150.r,
            ),
          ),
          const Gap(50),
          CustomTextFormField(hintText: 'Email', controller: _emailController),
          const Gap(20),
          CustomTextFormField(hintText: 'Name', controller: _nameController),
          const Gap(20),
          CustomTextFormField(
            hintText: 'Phone Number',
            controller: _phoneController,
          ),
          const Gap(20),
          CustomTextFormField(
            hintText: 'Password',
            controller: _passwordController,
          ),
          const Gap(20),
          CustomDropDownMenu(controller: _roleController),
          const Gap(32),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                showLoadingBox(context);
              }
              if (state is AuthSuccess) {
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              }
              if (state is AuthError) {
                showErrorMessage(context, errMessage: state.message);
                Navigator.pop(context);
              }
            },
            child: DefaultAppButton(
              text: 'SignUp',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var user = UserModel(
                    email: _emailController.text.trim(),
                    name: _nameController.text.trim(),
                    phoneNumber: _phoneController.text.trim(),
                    role: _roleController.text == UserRole.delivery.name
                        ? UserRole.delivery
                        : UserRole.user,
                  );
                  context.read<AuthCubit>().register(
                    user,
                    _passwordController.text.trim(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
