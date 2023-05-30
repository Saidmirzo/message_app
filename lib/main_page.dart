import 'package:flutter/material.dart';
import 'package:message_app/features/auth/presentattion/pages/sifn_in_page.dart';
import 'package:message_app/features/home/presentation/pages/home_page.dart';

import 'logic/helper_functions.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInState();
  }

  void getUserLoggedInState() async {
    await HeplerFunctions.getUserLoggedInStatus().then((value) {
      setState(() {
        _isSignedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSignedIn) {
      return const HomePage();
    } else {
      return const SignInPage();
    }
  }
}
