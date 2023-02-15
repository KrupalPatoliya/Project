import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/records.dart';

class RecordDataBaseHelpper {
  RecordDataBaseHelpper._();

  static final RecordDataBaseHelpper dataBaseHelpper = RecordDataBaseHelpper._();

  Database? db;

  String dBName = "myDB.db";
  String tableName = "Employee";
  String colId = "ID";
  String colName = "path";

  Future<Database?> initDB() async {
    String dBPath = await getDatabasesPath();
    String path = join(dBPath, dBName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT)');
      },
    );

    log("===========================");
    log("Data base created");
    log("===========================");
    return db;
  }

  Future<int> insertData({
    required String name,
  }) async {
    db = await initDB();

    log("data insert");
    String query = "INSERT INTO $tableName($colName) VALUES (?);";
    List args = [name];
    log("data insert Successfully");
    return await db!.rawInsert(query, args);
  }

  Future<List<Records>?> fetchAllData() async {
    db = await initDB();

    String query = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<Records>? allEmployee = res.map((e) => Records.fromMap(data: e)).toList();

    log(allEmployee.toString());

    return allEmployee;
  }

  deleteData({required int id}) async {
    db = await initDB();

    String query = "DELETE FROM $tableName WHERE ID=?";
    List arg = [id];
    var res = await db!.rawDelete(query, arg);
    return res;
  }
}
