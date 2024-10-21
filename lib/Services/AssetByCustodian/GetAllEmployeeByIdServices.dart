import 'package:fats_mobile_demo/models/GetAllEmployeeListByIdModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class GetAllEmployeeByIdServices {
  static Future<List<GetAllEmployeeListByIdModel>> getAllEmployeeList(
      String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url =
        "${Constant.baseUrl}/getAssetMasterEncodeAssetCaptureFinalByEmpId/$id";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body) as List;
        List<GetAllEmployeeListByIdModel> employee =
            data.map((e) => GetAllEmployeeListByIdModel.fromJson(e)).toList();
        return employee;
      } else {
        throw Exception('Failed to load Employee list');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load Employee list');
    }
  }
}
