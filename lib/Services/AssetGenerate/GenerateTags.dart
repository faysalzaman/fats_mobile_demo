import 'package:fats_mobile_demo/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class GenerateTagsServices {
  static Future<String> tagGenerate(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url =
        "${Constant.baseUrl}/UpdateAssetMasterEncodeAssetCaptureTagNumber";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        Get.offAll(const HomeScreen());
        Get.snackbar(
          "Success",
          "Tags Generated Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          isDismissible: true,
        );
        return "Success";
      } else if (response.statusCode == 404) {
        Navigator.of(context).pop();
        Get.snackbar(
          "Error",
          "Failed to Generate Tags",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          isDismissible: true,
        );
        throw Exception('Failed to Generate Tags');
      } else {
        Navigator.of(context).pop();
        Get.snackbar(
          "Error",
          "Failed to Generate Tags",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          isDismissible: true,
        );
        throw Exception('Failed to Generate Tags');
      }
    } catch (e) {
      Navigator.of(context).pop();
      print(e);
      throw Exception('Failed to Generate Tags');
    }
  }
}
