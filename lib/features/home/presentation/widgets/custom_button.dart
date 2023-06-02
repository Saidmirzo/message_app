import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.onTap,
    this.color,
    required this.child,
  });

  final Function() onTap;
  Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.primary400,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
