import 'dart:convert';

import 'package:http/http.dart';
import 'package:rajaongkir_flutter/models/city_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajaongkir_flutter/models/cost_model.dart';

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

class CostApiService {
  String userUrl = 'https://api.rajaongkir.com/starter/cost';

  Future<CostModel> getCosts(
      String origin, String destination, String weight, String courier) async {
    Response response = await post(
      Uri.parse(userUrl),
      headers: {
        "key": "b8ac5ecac1211b3307320b995623cb41",
      },
      body: ({
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier,
      }),
    );
    if (response.statusCode == 200) {
      // print("halo");
      // print(response.body);
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      return CostModel.fromJson(responseJson);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final cityProvider = Provider<CityApiService>((ref) => CityApiService());

final costProvider = Provider<CostApiService>((ref) => CostApiService());

