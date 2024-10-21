import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class DeleteTagServices {
  static Future<void> deleteTag(String tag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url =
        "${Constant.baseUrl}/DeleteAssetMasterEncodeAssetCaptureById";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    final body = {"TagNumber": tag};

    try {
      var response =
          await http.delete(uri, headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        print("status code: ${response.statusCode}");

        Get.snackbar(
          "Success",
          "Tag Deleted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print("status code: ${response.statusCode}");
        Get.snackbar(
          "Error",
          "Failed to Delete Tag",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to Delete Tag');
    }
  }
}
