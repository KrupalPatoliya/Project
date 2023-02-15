import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductDataBaseHelper {
  ProductDataBaseHelper._();

  static ProductDataBaseHelper servicesDataBaseHelper = ProductDataBaseHelper._();

  Database? db;

  String dBName = "myDB.db";
  String tableName = "Product";
  String colId = "ID";
  String colName = "Name";
  String colDescription = "Description";
  String colImage = "Image";
  String colPrice = "Price";
  String colRate = "Rate";

  Future<Database?> initDB() async {
    String dBPath = await getDatabasesPath();
    String path = join(dBPath, dBName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDescription TEXT,$colPrice INT, $colImage TEXT,$colRate INT)');
      },
    );

    log("===========================");
    log("Data base created");
    log("===========================");
    return db;
  }

  Future<int> insertData({
    required String name,
    required String description,
    required int price,
    required String image,
    required int rate,
  }) async {
    db = await initDB();

    log("data insert");
    String query = "INSERT INTO $tableName($colName,$colDescription,$colPrice,$colImage,$colRate) VALUES (?,?,?,?,?);";
    List args = [name, description, price, image, rate];
    log("data insert Successfully");
    return await db!.rawInsert(query, args);
  }

  Future<List<Products>?> fetchAllData() async {
    db = await initDB();

    String query = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<Products>? allProducts = res.map((e) => Products.fromMap(data: e)).toList();

    log(allProducts.toString());

    return allProducts;
  }

  fetchSingleData({required int id}) async {
    db = await initDB();
    String query = "SELECT * FROM $tableName WHERE id = $id;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);
  }

  updateData({
    required int id,
    required String name,
    required String description,
    required int price,
    required String image,
    required int rate,
  }) async {
    db = await initDB();

    log("data Update");
    String query = "UPDATE $tableName SET $colName = ?,$colDescription = ?,$colPrice = ?,$colImage = ?,$colRate = ? WHERE $colId = ?;";

    List args = [name, description, price, image, rate, id];

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

class Products {
  int? id;
  String name;
  String description;
  int price;
  String image;
  int rate;

  Products({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rate,
  });

  factory Products.fromMap({required Map data}) {
    return Products(
      id: data['ID'],
      name: data["Name"],
      description: data["Description"],
      price: data["Price"],
      image: data["Image"],
      rate: data["Rate"],
    );
  }
}
