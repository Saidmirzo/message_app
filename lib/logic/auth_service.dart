import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_app/logic/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginWithUserNameAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      log(user. toString());

      if (user != null) {
        return true; 
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        DataBaseService(uid: user.uid).updateUserData(fullName, email);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
