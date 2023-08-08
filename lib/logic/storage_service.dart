import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storageRef = FirebaseStorage.instance.ref();
  Future<String>   uploadFile({required  File image,required  String userId, String? imageCategory}) async {
    final userImage = storageRef.child("${imageCategory??"userImages"}/$userId.jpg");
    await userImage.putFile(image);
    return await userImage.getDownloadURL();
  }
}
