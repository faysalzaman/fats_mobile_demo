// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../models/AssetByLocationModel.dart';

class GetAllAssetByLocationServices {
  static Future<List<AssetByLocationModel>> getAllEmployeeList(
      String locationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url =
        "${Constant.baseUrl}/getAssetMasterEncodeAssetCaptureFinalByLocationTag/$locationId";
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
        List<AssetByLocationModel> assetByLocationModelList =
            data.map((e) => AssetByLocationModel.fromJson(e)).toList();
        return assetByLocationModelList;
      } else {
        throw Exception('Failed to load Employee list');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load Employee list');
    }
  }
}
