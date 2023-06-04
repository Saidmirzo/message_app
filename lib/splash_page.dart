import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:message_app/config/constants/app_colors.dart';
import 'package:message_app/config/constants/assets.dart';
import 'package:message_app/config/routes/routes.dart';

import 'logic/helper_functions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool? _isSignedIn;

  @override
  void initState() {
    super.initState();
    getUserLoggedInState();
  }

  void getUserLoggedInState() async {
    _isSignedIn= await HeplerFunctions.getUserLoggedInStatus();
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.pushReplacementNamed(context, Routes.mainPage,
          arguments: {"isSignedIn": _isSignedIn});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral900,
      alignment: Alignment.center,
      child: SvgPicture.asset(Assets.images.logo),
    );
  }
}
