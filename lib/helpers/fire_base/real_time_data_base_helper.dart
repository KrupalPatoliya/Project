import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:training_app/models/real_time_employee.dart';

class RealTimeDataBaseHelper {
  RealTimeDataBaseHelper._();

  static final RealTimeDataBaseHelper realTimeDataBaseHelper = RealTimeDataBaseHelper._();
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> addData({
    required String pic,
    required String name,
    required String email,
    required String number,
    required String salary,
    required String designation,
    required String gender,
  }) async {
    DatabaseReference ref = database.ref("Employees/").push();
    await ref.set(
        {"id": ref.key, "name": name, "email": email, "number": number, "salary": salary, "designation": designation, "gender": gender, "pic": pic});
  }

  getData() {
    // addData(pic: "", name: "Krupali", email: "Krupali@gmail.com", number: "343534534522", salary: "3432432", designation: "Employee", gender: "Female");
    final ref = database.ref();
    final snapshot = ref.child('Employees/');

    return snapshot;
  }

  Future<void> upDateData({
    required String id,
    required String pic,
    required String name,
    required String email,
    required String number,
    required String salary,
    required String designation,
    required String gender,
  }) async {
    DatabaseReference ref = database.ref("Employees/").child(id);

    return await ref.update(
        {"id": id, "name": name, "email": email, "number": number, "salary": salary, "designation": designation, "gender": gender, "pic": pic});
  }

  deleteData({required String id}) async {
    await database.ref("Employees/").child(id).remove();
  }
}
