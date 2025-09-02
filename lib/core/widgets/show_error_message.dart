import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

void showErrorMessage(
  BuildContext context, {
  required String errMessage,
  int secondes = 4,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.primary,
      duration: Duration(seconds: secondes),
      content: Text(
        errMessage,
        style: AppStyles.regular22.copyWith(color: Colors.white),
      ),
    ),
  );
}
