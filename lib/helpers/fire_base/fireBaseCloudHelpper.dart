import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_app/models/todos.dart';

class FireBaseCloudHelpper {
  FireBaseCloudHelpper._();

  // - Create to do Table Which contain (id,task_title,task_description,createDate,doneDate,status)

  static final FireBaseCloudHelpper fireBaseCloudHelpper = FireBaseCloudHelpper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      {required String task_description,
      required String task_title,
      required String createDate,
      required String doneDate,
      required String status}) async {
    DocumentReference users = firestore.collection('ToDos').doc();
    users.set({
      'id' : users.id,
      'task_title': task_title,
      'task_description': task_description,
      'createDate': createDate,
      'doneDate': doneDate,
      'status': status,
    }).then((value) {
      Fluttertoast.showToast(
          msg: "Data Inserted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Not Data Add",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllData() {
    // firestore.collection('ToDos').snapshots();

    return firestore.collection('ToDos').snapshots();
  }

  List<ToDos> getAllData({required List data}) {
    List<ToDos> allData = [];

    for (int i = 0; i < data.length; i++) {
      allData.add(ToDos(
        id: data[i]['id'],
        task_title: data[i]['task_title'],
        task_description: data[i]['task_description'],
        createDate: data[i]['createDate'],
        doneDate: data[i]['doneDate'],
        status: data[i]['status'],
      ));
    }

    return allData;
  }

  Future<void> deleteUser({required String id}) {
    CollectionReference users = firestore.collection('ToDos');
    return users.doc(id).delete().then((value) => print("User Deleted")).catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateUser(
      {required String id,
      required String task_description,
      required String task_title,
      required String createDate,
      required String doneDate,
      required String status}) {
    CollectionReference users = firestore.collection('ToDos');

    return users.doc(id).update({
      'task_title': task_title,
      'task_description': task_description,
      'createDate': createDate,
      'doneDate': doneDate,
      'status': status,
    }).then((value) {
      Fluttertoast.showToast(
          msg: "Update User",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Not Data Update",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
