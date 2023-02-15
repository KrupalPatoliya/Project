import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:training_app/models/employee.dart';

class DataBaseHelpper {
  DataBaseHelpper._();

  static final DataBaseHelpper dataBaseHelpper = DataBaseHelpper._();

  Database? db;

  String dBName = "myDB.db";
  String tableName = "Employee";
  String colId = "id";
  String colName = "name";
  String colSalary = "salary";
  String colImage = "image";
  String colAge = "age";

  Future<Database?> initDB() async {
    String dBPath = await getDatabasesPath();
    String path = join(dBPath, dBName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colSalary INTEGER,$colAge INTEGER, $colImage BLOB)');
      },
    );

    return db;
  }

  Future<int> insertData({
    required String name,
    required Uint8List image,
    required int salary,
    required int age,
  }) async {
    db = await initDB();

    log("data insert");
    String query = "INSERT INTO $tableName($colName,$colSalary,$colAge,$colImage) VALUES (?,?,?,?);";
    List args = [name, salary, age, image];
    log("data insert Successfully");
    return await db!.rawInsert(query, args);
  }

  Future<List<Employee>?> fetchAllData() async {
    db = await initDB();

    String query = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    if (res.length == 0) {
      List<Employee>? allEmployee = res.map((e) => Employee.fromMap(e)).toList();

      log(allEmployee.toString());

      return allEmployee;
    }
    return null;
  }

  fetchSingleData({required int id}) async {
    db = await initDB();
    String query = "SELECT * FROM $tableName WHERE id = $id;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);
  }

  updateData({
    required int id,
    required String name,
    required Uint8List image,
    required int salary,
    required int age,
  }) async {
    db = await initDB();

    log("data Update");
    String query = "UPDATE $tableName SET Name = ?,Image = ?,Salary = ?,Age = ? WHERE ID = ?;";

    List args = [name, image, salary, age, id];

    var res = db!.rawUpdate(query, args);

    return res;
  }

  deleteData({required int id}) async {
    db = await initDB();

    String query = "DELETE FROM $tableName WHERE ID=?";
    List arg = [id];
    var res = await db!.rawDelete(query, arg);
    return res;
  }

  deleteAllData() async {
    db = await initDB();

    db!.rawDelete("DELETE FROM $tableName;");
  }
}
