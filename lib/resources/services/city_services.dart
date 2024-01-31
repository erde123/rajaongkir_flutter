import 'dart:convert';

import 'package:http/http.dart';
import 'package:rajaongkir_flutter/resources/models/city_model.dart';

class CityApiService {
  String userUrl = 'https://api.rajaongkir.com/starter/city';

  Future<CityModel> getCities() async {
    Response response = await get(Uri.parse(userUrl), headers: {
      "key": "b8ac5ecac1211b3307320b995623cb41",
    });
    if (response.statusCode == 200) {
      // print("halo");
      // print(response.body);
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      return CityModel.fromJson(responseJson);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}