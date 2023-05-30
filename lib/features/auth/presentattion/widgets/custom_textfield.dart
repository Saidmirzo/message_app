import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/all_constants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    required this.controller,
    required this.isPassword,
    this.autofocus,
    this.onSubmitted,
    this.inputFormatters,
    this.focusNode,
    this.title,
    this.isValidate = false,
    this.readOnly = false, this.margin,
  });

  final String? hintText;
  final String? title;
  bool isValidate;
  bool readOnly;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final bool? autofocus;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final EdgeInsets? margin;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != null
              ? Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 24.h, bottom: 9.h),
                  child: Text(
                    widget.title ?? '',
                    style: AppTextStyles.body14w4
                        .copyWith(color: AppColors.unActText),
                  ),
                )
              : const SizedBox.shrink(),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              readOnly: widget.readOnly,
              autofocus: widget.autofocus ?? false,
              validator: widget.isValidate
                  ? (value) => EmailValidator.validate(value ?? '')
                      ? null
                      : 'Please enter a valid email'
                  : null,
              style:
                  AppTextStyles.body18w4.copyWith(color: AppColors.textfield),
              controller: widget.controller,
              focusNode: widget.focusNode,
              cursorColor: AppColors.unActText,
              obscureText: widget.isPassword ? isHide : false,
              obscuringCharacter: '*',
              onFieldSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: () => setState(() => isHide = !isHide),
                        child: isHide
                            ? Icon(Icons.visibility_off_outlined,
                                color: AppColors.white)
                            : Icon(Icons.visibility_outlined,
                                color: AppColors.white),
                      )
                    : null,
                prefixIconConstraints:
                    BoxConstraints(maxHeight: 40.h, maxWidth: 40.w),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: widget.prefixIcon,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                ),
                filled: true,
                fillColor: AppColors.bgTextfield,
                hintStyle:
                    AppTextStyles.body18w4.copyWith(color: AppColors.unActText),
                hintText: widget.hintText ?? "text",
              ),
              inputFormatters: widget.inputFormatters,
            ),
          ),
        ],
      ),
    );
  }
}
