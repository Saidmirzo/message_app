import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_app/features/auth/data/models/user_register_model.dart';
import 'package:message_app/features/home/data/models/group_model.dart';
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
      "groups": [],
      "uid": uid,
    });
  }

  Future getUserInfo(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Stream getUserGroups() {
    return userCollection.doc(uid).snapshots();
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
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }

  Future<QuerySnapshot> searchGroupByName(String name) {
    return groupCollection.where("groupName", arrayContains: name).get();
  }

  Future toggleGroup(GroupModel groupModel) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(uid);

    final String userName = await HeplerFunctions.getUserName();
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List groups = documentSnapshot["groups"];
    final String groupItem = "${groupModel.groupId}_${groupModel.groupName}";
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
