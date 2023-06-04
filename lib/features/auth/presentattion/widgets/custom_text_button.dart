

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decorations.dart';
import '../../../../config/constants/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: AppDecorations.buttonStyle(
        bgColor: AppColors.primary400,
        borderRadius: 16.r,
        size: const Size.fromWidth(double.maxFinite),
        padding: EdgeInsets.symmetric(vertical: 18.h),
      ),
      child: Text(
        text,
        style: AppTextStyles.body14w7.copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }
}