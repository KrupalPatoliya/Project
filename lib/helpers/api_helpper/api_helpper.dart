import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/api_model.dart';

class ApiHelpper {
  ApiHelpper._();

  static final ApiHelpper apiHelpper = ApiHelpper._();

  String url = "http://192.168.29.72/Practical_Api/api/";

  Future<UserModelList?> fetchingMultipleData() async {
    http.Response response = await http.get(Uri.parse("${url}get_user_list"), headers: {
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    });

    if (response.statusCode == 200) {
      return UserModelList.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future addData({required String name, required String email, required File image}) async {
    Uri uri = Uri.parse("${url}add_user");

    var response = http.MultipartRequest("POST", uri);

    response.headers.addAll({
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    });


    print("=======================================");
    print(image.path);
    print("=======================================");

    response.fields['name'] = name;
    response.fields['email'] = email;
    response.files.add(
      await http.MultipartFile.fromPath('profile_pic', image.path),
    );

    log("data Add");

    var data = response.send();
    log("data Add $data");
  }

  Future<Map<dynamic, dynamic>> upDateData({required String name, required String email, required int id}) async {
    log("api call for Update");

    http.Response response = await http.put(Uri.parse("${url}edit_user_details"), headers: {
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    }, body: {

    "user_id": id.toString(),
    "name": name,
    "email": email,
  });
    log("api Update");
    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);

      decodedData['message'];

      return decodedData;
    }
    return {"message": 1};
  }

  Future deleteSingleData({required int? id}) async {
    log("api Calling");

    http.Response response = await http.delete(Uri.parse("${url}delete_user"), headers: {
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    }, body: {
      'user_id': id.toString()
    });

    log("api Calling");

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);

      decodedData['message'];

      return decodedData['statusCode'];
    }
    return null;
  }
}
