// ignore_for_file: file_names

import 'package:fats_mobile_demo/models/GetAllCitiesModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class GetAllCitiesService {
  static Future<List<GetAllCitiesModel>> getCityById(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/getAllCitybyTblCountryID/$id";
    final uri = Uri.parse(url);

    print(uri);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body) as List;
        List<GetAllCitiesModel> citiesList =
            data.map((e) => GetAllCitiesModel.fromJson(e)).toList();

        return citiesList;
      } else {
        throw Exception('Failed to load cities list');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load cities list');
    }
  }
}
