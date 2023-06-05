import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/user_register_model.dart';
import '../widgets/custom_text_button.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_styles.dart';
import '../../../../config/routes/routes.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.neutral900,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 24.w).copyWith(bottom: 20.h),
            child: Column(
              children: [
                SizedBox(height: 220.h),
                CustomTextField(
                  hintText: 'Full Name',
                  controller: fullName,
                  isPassword: false,
                ),
                CustomTextField(
                  hintText: 'Email',
                  controller: email,
                  isPassword: false,
                  isValidate: true,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 28.h),
                  child: CustomTextField(
                    hintText: 'Password',
                    controller: password,
                    isPassword: true,
                  ),
                ),
                const Spacer(),

                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 40.h),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       SvgPicture.asset(Assets.icons.google, height: 80.h),
                //     ],
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: Divider(
                //         height: 1,
                //         thickness: 1,
                //         indent: 24.w,
                //         endIndent: 20.w,
                //         color: AppColors.black.withOpacity(.2),
                //       ),
                //     ),
                //     Text(
                //       'Don’t have an account?',
                //       style: AppTextStyles.body16w5
                //           .copyWith(color: AppColors.unActText),
                //     ),
                //     Expanded(
                //       child: Divider(
                //         height: 1,
                //         thickness: 1,
                //         indent: 20.w,
                //         endIndent: 24.w,
                //         color: AppColors.black.withOpacity(.2),
                //       ),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: EdgeInsets.only(bottom: 38.h),
                  child: Text.rich(
                    TextSpan(
                      text: 'Sign in',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(
                              context, Routes.signInPage);
                        },
                      style: AppTextStyles.body18w7.copyWith(
                        color: AppColors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                CustomTextButton(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.uploadPhotoPage,
                      arguments: {
                        "userRegisterModel": UserRegisterModel(
                          fullName: fullName.text.trim(),
                          email: email.text.trim(),
                          password: password.text.trim(),
                          userImage: '',
                        ),
                      },
                    );
                  },
                  text: 'Next',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
