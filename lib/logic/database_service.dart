import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;
  DataBaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  Future updateUserData(String fullName, String email) async {
    // groupCollection.doc(uid).
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "uid": uid,
    });
  }

  Future getUserInfo(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    log(snapshot.toString());
  }
}
