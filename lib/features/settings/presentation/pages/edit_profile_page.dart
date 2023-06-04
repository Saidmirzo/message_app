import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:message_app/config/constants/app_colors.dart';
import 'package:message_app/config/constants/app_text_styles.dart';
import 'package:message_app/config/constants/assets.dart';
import 'package:message_app/features/auth/data/models/user_model.dart';
import 'package:message_app/features/auth/presentattion/widgets/custom_text_button.dart';
import 'package:message_app/widgets/custom_avatar.dart';

import '../bloc/settings/settings_bloc.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.neutral700,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.neutral700,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          UserModel userModel = context.read<SettingsBloc>().userModel;
          String  userImage = context.read<SettingsBloc>().userImage;
          nameController.text = userModel.fullName ?? '';
          if (state is SettingsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SettingsErrorState) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.body20w5.copyWith(
                  color: AppColors.white,
                ),
              ),
            );
          } else {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      height: 100.h,
                      color: AppColors.neutral700,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w)
                            .copyWith(top: 120.h, bottom: 25.h),
                        width: double.maxFinite,
                        color: AppColors.neutral800,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: AppTextStyles.body14w5.copyWith(
                                color: AppColors.neutral50,
                              ),
                            ),
                            Container(
                              height: 56.h,
                              margin: EdgeInsets.only(top: 10.h),
                              padding: EdgeInsets.only(left: 22.w),
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.neutral500),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(Assets.icons.user),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: TextField(
                                      style: AppTextStyles.body14w5.copyWith(
                                        color: AppColors.white,
                                      ),
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter your full name",
                                        hintStyle:
                                            AppTextStyles.body14w5.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            CustomTextButton(
                              text: "Save",
                              onTap: () {
                                context.read<SettingsBloc>().add(
                                      SaveChanges(
                                        userModel: userModel.copyWith(
                                          fullName: nameController.text,
                                        ),
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomAvatar(
                      size: 148.h,
                      link: userModel.userImage,
                      image: userModel.userImage == null
                          ? Assets.images.defUserimaage
                          : null,
                      border: true,
                      filePath: userImage.isNotEmpty?userImage:null,
                      margin: EdgeInsets.only(top: 20.h),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<SettingsBloc>().add(UploadimageEvent());
                      },
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary400,
                        ),
                        child: SvgPicture.asset(Assets.icons.addPhoto),
                      ),
                    )
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
