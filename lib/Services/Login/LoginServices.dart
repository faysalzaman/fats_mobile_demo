// ignore_for_file: avoid_print

import 'package:fats_mobile_demo/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/CountriesListModel.dart';

class LoginServices {
  static Future<List<CountriesListModel>> countriesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/GetAllCountry";

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    print(headers);

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body) as List;
        List<CountriesListModel> countriesList =
            data.map((e) => CountriesListModel.fromJson(e)).toList();
        return countriesList;
      } else {
        var data = json.decode(response.body);
        var msg = data['message'];

        throw Exception(msg);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
