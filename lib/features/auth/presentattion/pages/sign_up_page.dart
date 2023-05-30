import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:message_app/features/auth/data/models/user_register_model.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_styles.dart';
import '../../../../config/constants/assets.dart';
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
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 200.h),
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
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                RegisterUserEvent(
                                    userRegisterModel: UserRegisterModel(
                                        email: email.text,
                                        fullName: fullName.text,
                                        password: password.text),
                                    context: context),
                              );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 22.h),
                          ),
                          textStyle:
                              MaterialStateProperty.all(AppTextStyles.body20w4),
                        ),
                        child: const Text('Sign in'),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(Assets.icons.google, height: 80.h),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        indent: 24.w,
                        endIndent: 20.w,
                        color: AppColors.black.withOpacity(.2),
                      ),
                    ),
                    Text(
                      'Don’t have an account?',
                      style: AppTextStyles.body16w5
                          .copyWith(color: AppColors.unActText),
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        indent: 20.w,
                        endIndent: 24.w,
                        color: AppColors.black.withOpacity(.2),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 11.h, bottom: 38.h),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Terms of use',
                      style: AppTextStyles.body16w5
                          .copyWith(color: AppColors.blue),
                    ),
                    Text(
                      'Privacy Policy',
                      style: AppTextStyles.body16w5
                          .copyWith(color: AppColors.blue),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
