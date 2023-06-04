import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_app/features/auth/data/models/user_model.dart';
import 'package:message_app/features/auth/data/models/user_register_model.dart';
import 'package:message_app/features/home/data/models/group_model.dart';
import 'package:message_app/features/home/data/models/search_group_model.dart';
import 'package:message_app/logic/helper_functions.dart';

class DataBaseService {
  final String? uid;

  DataBaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  Future saveUserData(UserRegisterModel userRegisterModel) async {
    // groupCollection.doc(uid).
    return await userCollection.doc(uid).set({
      "fullName": userRegisterModel.fullName,
      "email": userRegisterModel.email,
      "uid": uid,
      "userImage": userRegisterModel.userImage,
      "groups": [],
    });
  }

  Future getUserInfo(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future updateUserinfo(UserModel userModel) async {
    final DocumentReference docUser = userCollection.doc(userModel.uid);
    await docUser.update(userModel.toJson());
  }

  Future<UserModel> getUserInfoWithUserId() async {
    QuerySnapshot snapshot =
        await userCollection.where("uid", isEqualTo: uid).get();
    return UserModel.fromJson(
        jsonDecode(jsonEncode(snapshot.docs.first.data())));
  }

  Future<Stream<List<GroupModel>>> getUserGroups() async {
    final userDoc = await userCollection.doc(uid).get();
    final List listGroups = userDoc["groups"];
    final List onlyGroupId = listGroups
        .map((e) => e.toString().substring(0, e.toString().indexOf("_")))
        .toList();
    if (onlyGroupId.isEmpty) {
      return const Stream.empty();
    }

    return groupCollection
        .where("groupId", whereIn: onlyGroupId)
        .snapshots()
        .map((event) => buildGroupModel(event));
  }

  List<GroupModel> buildGroupModel(QuerySnapshot querySnapshot) {
    List list = querySnapshot.docs;
    List<GroupModel> groupList = [];
    for (var element in list) {
      groupList.add(GroupModel(
          admin: element["admin"],
          groupIcon: element["groupIcon"],
          groupId: element["groupId"],
          groupName: element["groupName"],
          members: element["members"],
          recentMessage: element["recentMessage"],
          recentMessageSenderName: element["recentMessageSenderName"],
          recentMessageTime: element["recentMessageTime"]));
    }
    // final group = await groupCollection.doc(groupId).get();
    return groupList;
  }

  Future createGroup(String username, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${uid}_$username",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSenderName": "",
      "recentMessageTime": "",
    });
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$username"]),
      "groupId": groupDocumentReference.id,
    });
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  Stream getChats(String groupId) {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    await groupCollection
        .doc(groupId)
        .collection("messages")
        .add(chatMessageData);

    await groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSenderName": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }

  Future<QuerySnapshot> searchGroupByName(String name) {
    return groupCollection.where("groupName", isEqualTo: name).get();
  }

  Future toggleGroup(SearchGroupModel SearchGroupModel) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference =
        groupCollection.doc(SearchGroupModel.groupId);

    final String userName = await HeplerFunctions.getUserName();
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List groups = documentSnapshot["groups"];
    final String groupItem =
        "${SearchGroupModel.groupId}_${SearchGroupModel.groupName}";
    final String userItem = "${uid}_$userName";

    if (groups.contains(groupItem)) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove([groupItem])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove([userItem])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion([groupItem])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion([userItem])
      });
    }
  }
}
