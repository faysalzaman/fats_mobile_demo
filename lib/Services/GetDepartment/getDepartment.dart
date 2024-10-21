import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../models/GetAllDepartmentsModel.dart';

class GetAllDepartmentsService {
  static Future<List<GetAllDepartmentsModel>> getAllDepartments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/GetAllNewDepartmentLit";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    try {
      var response = await http.get(uri, headers: headers);
      print(json.decode(response.body));
      var data = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        List<GetAllDepartmentsModel> getAllDep =
            data.map((e) => GetAllDepartmentsModel.fromJson(e)).toList();
        return getAllDep;
      } else {
        throw Exception('Failed to load cities list');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load cities list');
    }
  }
}
