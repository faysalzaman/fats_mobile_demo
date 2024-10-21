// ignore_for_file: avoid_print

import 'package:fats_mobile_demo/models/AssetConditionModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class AssetConditionServices {
  static Future<List<AssetConditionModel>> assetCondition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/GetAllAssetCondition";
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
        List<AssetConditionModel> assetConditionModel =
            jsonResponse.map((e) => AssetConditionModel.fromJson(e)).toList();
        return assetConditionModel;
      } else {
        throw Exception('Failed to load cities list');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load cities list');
    }
  }
}
