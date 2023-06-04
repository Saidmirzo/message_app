import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:message_app/config/constants/app_colors.dart';
import 'package:message_app/config/constants/app_text_styles.dart';
import 'package:message_app/config/constants/assets.dart';
import 'package:message_app/config/routes/routes.dart';
import 'package:message_app/features/auth/data/models/user_model.dart';
import 'package:message_app/widgets/custom_avatar.dart';

import '../../../auth/presentattion/bloc/auth_bloc.dart';
import '../bloc/settings/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(GetUserInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral800,
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SettingsLoadedState) {
            UserModel userModel = context.read<SettingsBloc>().userModel;
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Settings",
                      style: AppTextStyles.body24wB.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.editProfilePage,
                          arguments: {"userModel": userModel},
                        );
                      },
                      child: Row(
                        children: [
                          CustomAvatar(
                            size: 64.h,
                            link: userModel.userImage!,
                          ),
                          SizedBox(width: 20.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel.fullName ?? "",
                                style: AppTextStyles.body20wB.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                userModel.email != null
                                    ? userModel.email!.substring(
                                        0, userModel.email!.indexOf("@"))
                                    : "",
                                style: AppTextStyles.body16w5
                                    .copyWith(color: AppColors.neutral100),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Divider(
                        color: AppColors.neutral600,
                        thickness: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () => context
                          .read<AuthBloc>()
                          .add(LogOutEvent(context: context)),
                      child: Row(
                        children: [
                          Container(
                            height: 35.h,
                            width: 35.h,
                            margin: EdgeInsets.only(right: 12.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.neutral600,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(Assets.icons.logout),
                          ),
                          Text(
                            'Logout',
                            style: AppTextStyles.body16w5.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is SettingsErrorState) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.body10w6.copyWith(
                  color: AppColors.white,
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
