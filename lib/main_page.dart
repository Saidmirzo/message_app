import 'package:flutter/material.dart';
import 'features/auth/presentattion/pages/sifn_in_page.dart';
import 'features/home/presentation/pages/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.isSignedIn});
  final bool isSignedIn;

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return const HomePage();
    } else {
      return const SignInPage();
    }
  }
}
