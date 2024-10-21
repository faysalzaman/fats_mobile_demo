// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../models/GetAllEmployeesModel.dart';

class GetAllEmployeesServices {
  static Future<List<GetAllEmployeesModel>> getAllEmployees() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/getAllEmployeeList";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        List<GetAllEmployeesModel> employee =
            data.map((e) => GetAllEmployeesModel.fromJson(e)).toList();
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
