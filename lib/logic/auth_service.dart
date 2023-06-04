import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_app/features/auth/data/models/user_register_model.dart';
import 'package:message_app/logic/database_service.dart';
import 'package:message_app/logic/helper_functions.dart';
import 'package:message_app/logic/storage_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future logOut() async {
    await firebaseAuth.signOut();
    HeplerFunctions.saveUserInfoToSf(false, "", "");
  }

  Future<String> loginWithUserNameAndPassword(
      String email, String password) async {
    User? user = (await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      final QuerySnapshot snapshot =
          await DataBaseService(uid: user.uid).getUserInfo(user.email!);
      HeplerFunctions.saveUserInfoToSf(
          true, snapshot.docs.first['email'], snapshot.docs.first['fullName']);
      return user.uid;
    }
    throw Exception("Login Exception user==null");
  }

  Future registerUserWithEmailAndPassword(
      UserRegisterModel userRegisterModel) async {
    User? user = (await firebaseAuth.createUserWithEmailAndPassword(
            email: userRegisterModel.email,
            password: userRegisterModel.password))
        .user;

    if (user != null) {
      final DataBaseService dataBaseService = DataBaseService(uid: user.uid);
      if (userRegisterModel.userImage.isNotEmpty) {
        final String imageUrl = await StorageService().uploadFile(
            image: File(userRegisterModel.userImage), userId: user.uid);
        userRegisterModel = userRegisterModel.copyWith(userImage: imageUrl);
      } else {
        userRegisterModel = userRegisterModel.copyWith(userImage: '');
      }
      dataBaseService.saveUserData(userRegisterModel);
      final QuerySnapshot snapshot =
          await dataBaseService.getUserInfo(user.email!);
      HeplerFunctions.saveUserInfoToSf(
          true, snapshot.docs.first['email'], snapshot.docs.first['fullName']);
    }
  }
}
