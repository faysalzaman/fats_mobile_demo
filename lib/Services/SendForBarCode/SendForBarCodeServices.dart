// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class SendForBarCodeServices {
  static Future<void> sendForBarCode(
    int QTY,
    final String MajorCategory,
    final String BusinessUnit,
    final String MajorCategoryDescription,
    final String MInorCategory,
    final String MinorCategoryDescription,
    final String aSSETdESCRIPTION,
    final String cOUNTRY,
    final String rEGION,
    final String CityName,
    final String Dao,
    final String DaoName,
    final String BUILDINGNO,
    final String FLOORNO,
    final String ModelofAsset,
    final String Manufacturer,
    final String buildingName,
    final String buildingAddress,
    final String UserLoginID,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/PostAssetMasterEncodeAssetCapture";
    final uri = Uri.parse(url);

    print(uri);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
    };

    print(token);

    final body = {
      "QTY": QTY,
      "MajorCategory": MajorCategory,
      "BusinessUnit": BusinessUnit,
      "MajorCategoryDescription": MajorCategoryDescription,
      "MInorCategory": MInorCategory,
      "MinorCategoryDescription": MinorCategoryDescription,
      "aSSETdESCRIPTION": aSSETdESCRIPTION,
      "cOUNTRY": cOUNTRY,
      "rEGION": rEGION,
      "CityName": CityName,
      "Dao": Dao,
      "DaoName": DaoName,
      "BUILDINGNO": BUILDINGNO,
      "FLOORNO": FLOORNO,
      "ModelofAsset": ModelofAsset,
      "Manufacturer": Manufacturer,
      "buildingName": buildingName,
      "buildingAddress": buildingAddress,
      "UserLoginID": UserLoginID
    };

    print(jsonEncode(body));

    try {
      var response =
          await http.post(uri, headers: headers, body: json.encode(body));

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status Code: ${response.statusCode}");
      } else {
        print("Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      print("The error is: $e");
    }
  }
}
