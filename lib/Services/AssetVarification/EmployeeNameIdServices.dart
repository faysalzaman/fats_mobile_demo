// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../models/EmployeeNameIdModel.dart';

class EmployeeNameIdServices {
  static Future<List<EmployeeNameIdModel>> nameIDMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/GetAllEmployeeList";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        List<EmployeeNameIdModel> employeeNameIdModel =
            jsonResponse.map((e) => EmployeeNameIdModel.fromJson(e)).toList();
        return employeeNameIdModel;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load data');
    }
  }
}
