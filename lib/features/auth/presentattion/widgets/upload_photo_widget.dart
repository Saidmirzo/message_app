import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/constants/app_text_styles.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';
import '../../../../widgets/custom_avatar.dart';
import '../bloc/auth_bloc.dart';

class UploadPhotoWidget extends StatelessWidget {
  const UploadPhotoWidget({
    super.key,
    required this.state,
  });
  final AuthState state;
  final String waitString = "Wait a second, your photo still uploading";
  final String doneString = "Done! Your photo successfully uploaded";

  @override
  Widget build(BuildContext context) {
    bool isLoading = state is ImageUploadingState;
    bool isLoaded = state is ImageUploadedState;

    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            isLoaded
                ? CustomAvatar(
                    size: 164.h,
                    filePath: context.read<AuthBloc>().userImage,
                  )
                : CustomAvatar(
                    size: 164.h,
                    image: isLoading
                        ? Assets.images.uploadingUserimage
                        : Assets.images.defUserimaage),
            InkWell(
              onTap: () {
                if (!isLoaded) {
                  context.read<AuthBloc>().add(UploadImageEvent());
                }
              },
              child: Container(
                height: 40.h,
                width: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary400,
                ),
                child: isLoaded
                    ? SvgPicture.asset(Assets.icons.check)
                    : SvgPicture.asset(Assets.icons.addPhoto),
              ),
            )
          ],
        ),
        Text(
          isLoading
              ? waitString
              : isLoaded
                  ? doneString
                  : '',
          style: AppTextStyles.body16w5.copyWith(
            color: AppColors.neutral200,
          ),
        ),
      ],
    );
  }
}
