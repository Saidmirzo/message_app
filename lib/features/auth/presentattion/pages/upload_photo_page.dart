import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:message_app/config/constants/all_constants.dart';
import 'package:message_app/features/auth/data/models/user_register_model.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/upload_photo_widget.dart';

class UploadPhotoPage extends StatelessWidget {
  const UploadPhotoPage({super.key, required this.userRegisterModel});
  final UserRegisterModel userRegisterModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral900,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.neutral900,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new),
          splashRadius: 20,
          style: AppDecorations.buttonStyle(
            borderRadius: 12.r,
            padding: EdgeInsets.all(8.h),
            border: BorderSide(
              color: AppColors.white,
            ),
          ),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else {
            return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload a photo',
                  style: AppTextStyles.body24wB.copyWith(
                    color: AppColors.white,
                  ),
                ),
                UploadPhotoWidget(state: state),
                Visibility(
                  visible: state is! ImageUploadingState,
                  child: CustomTextButton(
                    onTap: () {
                      context.read<AuthBloc>().add(
                            RegisterUserEvent(
                              userRegisterModel: userRegisterModel.copyWith(
                                  userImage:
                                      context.read<AuthBloc>().userImage),
                              context: context,
                            ),
                          );
                    },
                    text: "Upload Photo",
                  ),
                )
              ],
            ),
          );
          }
        },
      ),
    );
  }
}
