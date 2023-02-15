import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WorkerDataBaseHelper {
  WorkerDataBaseHelper._();

  static WorkerDataBaseHelper servicesDataBaseHelper = WorkerDataBaseHelper._();

  Database? db;

  String dBName = "myDB.db";
  String tableName = "Workers";
  String colId = "ID";
  String colName = "Name";
  String colPhoto = "Photo";
  String colGender = "Gender";
  String colMobile = "Mobile";
  String colAddress = "Address";
  String colSalary = "WorkType";
  String colWorkType = "Salary";

  Future<Database?> initDB() async {
    String dBPath = await getDatabasesPath();
    String path = join(dBPath, dBName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colPhoto TEXT,$colMobile INT, $colGender TEXT,$colAddress TEXT,$colSalary INT,$colWorkType TEXT)');
      },
    );

    log("===========================");
    log("Data base created");
    log("===========================");
    return db;
  }

  Future<int> insertData({
    required String name,
    required String photo,
    required int mobile,
    required String gender,
    required String address,
    required int salary,
    required String workType,
  }) async {
    db = await initDB();

    log("data insert");
    String query = "INSERT INTO $tableName($colName,$colPhoto,$colMobile,$colGender,$colAddress,$colSalary,$colWorkType) VALUES (?,?,?,?,?,?,?);";
    List args = [name, photo, mobile, gender, address, salary, workType];
    log("data insert Successfully");
    return await db!.rawInsert(query, args);
  }

  Future<List<Workers>?> fetchAllData() async {
    db = await initDB();

    String query = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<Workers>? allServices = res.map((e) => Workers.fromMap(data: e)).toList();

    log(allServices.toString());

    return allServices;
  }

  fetchSingleData({required int id}) async {
    db = await initDB();
    String query = "SELECT * FROM $tableName WHERE id = $id;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);
  }

  updateData({
    required int id,
    required String name,
    required String photo,
    required int mobile,
    required String gender,
    required String address,
    required int salary,
    required String workType,
  }) async {
    db = await initDB();

    log("data Update");
    String query =
        "UPDATE $tableName SET $colName = ?,$colPhoto = ?,$colMobile = ?,$colGender = ?,$colAddress = ?,$colSalary = ?,$colWorkType = ? WHERE $colId = ?;";

    List args = [name, photo, mobile, gender, address, salary, workType, id];

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

class Workers {
  int? id;
  String name;
  String photo;
  int mobile;
  String gender;
  String address;
  int salary;
  String workType;

  Workers({
    this.id,
    required this.name,
    required this.photo,
    required this.mobile,
    required this.gender,
    required this.address,
    required this.salary,
    required this.workType,
  });

  factory Workers.fromMap({required Map data}) {
    return Workers(
      id: data['ID'],
      name: data["Name"],
      photo: data["Photo"],
      mobile: data["Mobile"],
      gender: data["Gender"],
      address: data["Address"],
      salary: data["Salary"],
      workType: data["WorkType"],
    );
  }
}
