import 'package:flutter/material.dart';
import 'package:message_app/features/auth/presentattion/pages/sifn_in_page.dart';
import 'package:message_app/main_page.dart';


class Routes {

  static const mainPage = '/';
  static const signInPage = '/signInPage';

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
        case mainPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const SignInPage(),
          );
        default:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const MainPage(),
          );
      }
    } catch (e) {
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainPage(),
      );
    }
  }
}
