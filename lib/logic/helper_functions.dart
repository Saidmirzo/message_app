import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/config/constants/app_colors.dart';
import 'package:message_app/config/constants/app_text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/presentation/bloc/home/home_bloc.dart';

class HeplerFunctions {
  static String userLoggedInKey = "userLoggedInKey";
  static String userNameKey = "userNameKey";
  static String userEmailKey = "userEmailKey";

  //savving the data to SF
  static Future<bool> saveUserLoggedInState(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserName(String value) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, value);
  }

  static Future<bool> saveUserEmail(String value) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, value);
  }

  static Future saveUserInfoToSf(
      bool isUserLoggedIn, String email, String fullName) async {
    HeplerFunctions.saveUserLoggedInState(isUserLoggedIn);
    HeplerFunctions.saveUserEmail(email);
    HeplerFunctions.saveUserName(fullName);
  }

  //getting the data from Sf

  static Future<bool> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey) ?? false;
  }

  static Future<String> getUserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey) ?? "";
  }

  static Future<String> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey) ?? "";
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.red,
      duration: const Duration(seconds: 2),
      content: Text(
        message,
        style: AppTextStyles.body20w5.copyWith(color: AppColors.black),
      ),
    ),
  );
}

void showProgress(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: AppColors.black.withOpacity(.1),
    builder: (context) => Center(
      child: CircularProgressIndicator(
        color: AppColors.red,
      ),
    ),
  );
}

popUpDialog(BuildContext context) {
  final TextEditingController groupController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Create group',
          style: AppTextStyles.body16w4,
        ),
        content: TextField(
          controller: groupController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          IconButton(
            onPressed: () {
              HeplerFunctions.getUserName().then(
                (userName) {
                  context.read<HomeBloc>().add(CreateGroupEvent(
                        groupName: groupController.text,
                        userName: userName,
                      ));
                  Navigator.pop(context);
                },
              );
            },
            icon: const Icon(Icons.assignment_turned_in_rounded),
          )
        ],
      );
    },
  );
}

alertDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.neutral700,
        title: Text(
          'Sign Out',
          style: AppTextStyles.body16w4.copyWith(
            color: AppColors.white,
          ),
        ),
        content: Text(
          'Are you sure log out',
          style: AppTextStyles.body20w7.copyWith(
            color: AppColors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              "NO",
              style: AppTextStyles.body16w7.copyWith(
                color: AppColors.primary400,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              "Yes",
              style: AppTextStyles.body16w7.copyWith(
                color: AppColors.white,
              ),
            ),
          )
        ],
      );
    },
  );
}
