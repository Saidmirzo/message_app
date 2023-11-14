import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants/all_constants.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.title,
    required this.iconPath,
    required this.ontap,
  });
  final String title;
  final String iconPath;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Container(
            height: 35.h,
            width: 35.h,
            margin: EdgeInsets.only(right: 12.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.neutral600, shape: BoxShape.circle),
            child: SvgPicture.asset(Assets.icons.logout),
          ),
          Text(
            title,
            style: AppTextStyles.body16w5.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
