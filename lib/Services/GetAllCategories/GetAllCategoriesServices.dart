import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../models/GetAllCategoriesModel.dart';

class GetAllCategoriesServices {
  static Future<List<GetAllCategoriesModel>> getAllCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/GetAllMAINSUBSeriesNo";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": "gs1ksa.org:7001",
    };

    print(uri);
    print(headers);

    try {
      var response = await http.get(uri, headers: headers);

      var data = json.decode(response.body);
      print(data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Categories List Got Successfully");
        var data = json.decode(response.body) as List;
        List<GetAllCategoriesModel> categoriesList =
            data.map((e) => GetAllCategoriesModel.fromJson(e)).toList();
        return categoriesList;
      } else {
        throw Exception('Failed to load Categories list');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load Categories list');
    }
  }
}
