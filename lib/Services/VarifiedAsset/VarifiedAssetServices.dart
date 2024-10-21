// ignore_for_file: file_names

import 'package:fats_mobile_demo/models/VarifiedAssetModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class VarifiedAssetServices {
  static Future<List<VarifiedAssetModel>> varifiedAsset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url =
        "${Constant.baseUrl}/GetAllAssetMasterEncodeAssetCaptureFinal";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("status code: ${response.statusCode}");
        var data = json.decode(response.body);
        List<VarifiedAssetModel> varifiedAssetModel =
            (data as List).map((e) => VarifiedAssetModel.fromJson(e)).toList();
        return varifiedAssetModel;
      } else if (response.statusCode == 404) {
        throw Exception('Failed to load Data');
      } else {
        print("status code: ${response.statusCode}");
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load Data');
    }
  }
}
