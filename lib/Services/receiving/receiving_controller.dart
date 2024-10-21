// ignore_for_file: depend_on_referenced_packages

import 'package:fats_mobile_demo/constants.dart';
import 'package:fats_mobile_demo/models/PODetailsModel.dart';
import 'package:fats_mobile_demo/models/POMasterModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReceivingController {
  static Future<List<POMasterModel>> getPOMaster() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    Uri uri = Uri.parse("${Constant.newBaseUrl}/POMaster");

    final headers = <String, String>{
      "Authorization": token,
    };

    var response = await http.get(uri, headers: headers);

    var data = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var dataList = data['records'] as List;
      List<POMasterModel> poMasterList =
          dataList.map((e) => POMasterModel.fromJson(e)).toList();
      return poMasterList;
    } else {
      throw Exception(data['error']);
    }
  }

  static Future<List<PODetailsModel>> getPODetails(
    String pOMasterID,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    Uri uri =
        Uri.parse("${Constant.newBaseUrl}/PODetails?POMasterID=$pOMasterID");

    final headers = <String, String>{
      "Authorization": token,
    };

    var response = await http.get(uri, headers: headers);

    var data = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var dataList = data['records'] as List;
      List<PODetailsModel> poMasterList =
          dataList.map((e) => PODetailsModel.fromJson(e)).toList();
      return poMasterList;
    } else {
      throw Exception(data['error']);
    }
  }
}
