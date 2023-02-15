import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:training_app/models/userdata.dart';

class LazyLoadingApiHelpper {
  LazyLoadingApiHelpper._();

  static final LazyLoadingApiHelpper lazyLoadingApiHelpper = LazyLoadingApiHelpper._();

  Future<List<UserData>?> fetchingMultipleData({required int id,required int result}) async {
    http.Response response = await http.get(
      Uri.parse("https://randomuser.me/api/?page=$id&results=$result&seed=abc"),
    );

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);

      List data = decodedData['results'];

      List<UserData> userData = <UserData>[];
      data.map((e) => userData.add(UserData.fromMap(data: e))).toList();

      log(userData.first.name);
      return userData;
    }
    return null;
  }
}
