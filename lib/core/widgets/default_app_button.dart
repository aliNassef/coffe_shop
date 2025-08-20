import '../utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../extensions/padding_extension.dart';

import '../utils/app_styles.dart';

class DefaultAppButton extends StatelessWidget {
  const DefaultAppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.light,
    this.icon = const SizedBox(),
    this.padding = 0,
    this.radius = 20,
  });
  final String text;
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Widget icon;
  final double padding;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 16),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        alignment: Alignment.center,
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: AppStyles.regular20.copyWith(color: textColor)),
          icon,
        ],
      ),
    ).withHorizontalPadding(padding);
  }
}
