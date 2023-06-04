import 'package:flutter/material.dart';
import 'package:message_app/features/auth/presentattion/pages/sifn_in_page.dart';
import 'package:message_app/features/auth/presentattion/pages/upload_photo_page.dart';
import 'package:message_app/features/home/presentation/pages/chat_page.dart';
import 'package:message_app/features/home/presentation/pages/home_page.dart';
import 'package:message_app/features/home/presentation/pages/search_page.dart';
import 'package:message_app/features/settings/presentation/pages/edit_profile_page.dart';
import 'package:message_app/features/settings/presentation/pages/settings_page.dart';
import 'package:message_app/main_page.dart';
import 'package:message_app/splash_page.dart';

import '../../features/auth/presentattion/pages/sign_up_page.dart';

class Routes {
  static const splashPage = '/';
  static const mainPage = '/mainPage';
  static const signInPage = '/signInPage';
  static const signUpPage = '/signUpPage';
  static const homePage = '/homePage';
  static const chatPage = '/chatPage';
  static const searchPage = '/searchPage';
  static const settingsPage = '/settingsPage';
  static const editProfilePage = '/editProfilePage';
  static const uploadPhotoPage = '/uploadPhotoPage';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case signInPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const SignInPage(),
          );
        case signUpPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const SignUpPage(),
          );
        case homePage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const HomePage(),
          );
        case mainPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => MainPage(isSignedIn: args!["isSignedIn"]),
          );
        case chatPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => ChatPage(groupModel: args!["groupModel"]),
          );
        case searchPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const SearchPage(),
          );
        case splashPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const SplashPage(),
          );
        case settingsPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const SettingsPage(),
          );
        case editProfilePage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => EditProfilePage(),
          );
        case uploadPhotoPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => UploadPhotoPage(
              userRegisterModel: args!["userRegisterModel"],
            ),
          );
        default:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const SplashPage(),
          );
      }
    } catch (e) {
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashPage(),
      );
    }
  }
}
