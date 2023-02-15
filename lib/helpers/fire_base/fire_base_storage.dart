import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStorageHelpper {
  FireBaseStorageHelpper._();

  static FireBaseStorageHelpper fireBaseStorageHelpper = FireBaseStorageHelpper._();

  FirebaseStorage storage = FirebaseStorage.instanceFor();

  final storageRef = FirebaseStorage.instance.ref();

  Future<String> insertImage({required File file}) async {
    await storageRef.child(file.path.split("/").last.toString()).putFile(file);

    String listResult = await storageRef.child(file.path.split("/").last.toString()).getDownloadURL();

    return listResult;
  }

  removeImage({required String file}) async {
    return storageRef.child(file).delete().then((value) {
      print("delete");
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
