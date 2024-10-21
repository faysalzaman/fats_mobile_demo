// ignore_for_file: avoid_print, use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class AddNewBrandServices {
  static Future<void> addBrand(
    String brandName,
    String sCode,
    String mCode,
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/PostMakelist";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    final body = {
      "TblMakeName": brandName,
      "TblMakeMainCode": mCode,
      "tblMajorCode": sCode
    };

    print('body: ${jsonEncode(body)}');

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print('status code: ${response.statusCode}');
        var data = json.decode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Brand Added Successfully"),
            duration: Duration(seconds: 4),
          ),
        );
        Navigator.of(context).pop();
      } else {
        print('status code: ${response.statusCode}');
        throw Exception('Failed to load cities list');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load cities list');
    }
  }
}
