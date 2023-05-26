import 'package:flutter/material.dart';

import 'logic/helper_dunctions.dart';

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
    return Scaffold(
      body: Center(
        child: Builder(builder: (context) {
          return Text('My Home Page');
        }),
      ),
    );
  }
}
