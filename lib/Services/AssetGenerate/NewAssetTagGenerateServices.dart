import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../models/AssetGenerateModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NewAssetTagGenerateServices {
  static Future<List<AssetGenerateModel>> tagGenerate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url =
        "${Constant.baseUrl}/getAllAssetMasterEncodeAssetCaptureWithNoTag";
    final uri = Uri.parse(url);

    print(
        "url: ${Constant.baseUrl}/getAllAssetMasterEncodeAssetCaptureWithNoTag");

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    print("headers: $headers");

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("status code: ${response.statusCode}");
        var data = json.decode(response.body);
        List<AssetGenerateModel> assetGenerateModel =
            (data as List).map((e) => AssetGenerateModel.fromJson(e)).toList();
        return assetGenerateModel;
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
