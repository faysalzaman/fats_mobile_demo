import 'package:fats_mobile_demo/models/GetEmployeeListByIdModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class GetEmployeeListByIdServices {
  static Future<GetEmployeeListByIdModel> GetEmpListByID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/getEmployeeListById";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    final body = {"EmpID": id};

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: json.encode(body),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('status code: ${response.statusCode}');

        var data = json.decode(response.body);

        return GetEmployeeListByIdModel.fromJson(data);
      } else {
        print('status code: ${response.statusCode}');
        throw Exception('Failed to Get Data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to Get Data');
    }
  }
}
