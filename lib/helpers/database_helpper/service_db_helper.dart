import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ServicesDataBaseHelper {
  ServicesDataBaseHelper._();

  static ServicesDataBaseHelper servicesDataBaseHelper = ServicesDataBaseHelper._();

  Database? db;

  String dBName = "myDB.db";
  String tableName = "Services";
  String colId = "ID";
  String colName = "Name";
  String colCategory = "Category";
  String colPrice = "Price";
  String colFeatures = "Features";
  String colDurationOne = "DurationOne";
  String colDurationTwo = "DurationTwo";

  Future<Database?> initDB() async {
    String dBPath = await getDatabasesPath();
    String path = join(dBPath, dBName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colCategory TEXT,$colFeatures TEXT, $colPrice INT,$colDurationOne TEXT,$colDurationTwo TEXT)');
      },
    );

    log("===========================");
    log("Data base created");
    log("===========================");
    return db;
  }

  Future<int> insertData({
    required String name,
    required String category,
    required String features,
    required int price,
    required String durationOne,
    required String durationTwo,
  }) async {
    db = await initDB();

    log("data insert");
    String query = "INSERT INTO $tableName($colName,$colCategory,$colFeatures,$colPrice,$colDurationOne,$colDurationTwo) VALUES (?,?,?,?,?,?);";
    List args = [name, category, features, price, durationOne, durationTwo];
    log("data insert Successfully");
    return await db!.rawInsert(query, args);
  }

  Future<List<Services>?> fetchAllData() async {
    db = await initDB();

    String query = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<Services>? allServices = res.map((e) => Services.fromMap(data: e)).toList();

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
    required String category,
    required String features,
    required int price,
    required String durationOne,
    required String durationTwo,
  }) async {
    db = await initDB();

    log("data Update");
    String query =
        "UPDATE $tableName SET $colName = ?,$colCategory = ?,$colFeatures = ?,$colPrice = ?,$colDurationOne = ?,$colDurationTwo = ? WHERE $colId = ?;";

    List args = [name, category, features, price, durationOne, durationTwo, id];

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

class Services {
  int? id;
  String name;
  String category;
  String features;
  int price;
  String durationOne;
  String durationTwo;

  Services({
    this.id,
    required this.name,
    required this.category,
    required this.features,
    required this.price,
    required this.durationOne,
    required this.durationTwo,
  });

  factory Services.fromMap({required Map data}) {
    return Services(
      id: data['ID'],
      name: data["Name"],
      category: data["Category"],
      features: data["Features"],
      price: data["Price"],
      durationOne: data["DurationOne"],
      durationTwo: data["DurationTwo"],
    );
  }
}
