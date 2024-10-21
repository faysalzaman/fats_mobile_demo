// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class GetAreaServices {
  static Future<String> getArea(String regionCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/getRegionById";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    final body = {"RegionCode": regionCode};

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print("Area Got Successfully");
        var data = json.decode(response.body);

        String areaName = data['recordset'][0]['RegionName'];
        return areaName;
      } else {
        throw Exception('Failed to load Area');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
