// ignore_for_file: non_constant_identifier_names, unused_import, unnecessary_this, file_names
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Results {
  final String city_id;
  final String type;
  final String city_name;

  Results({required this.city_id, required this.type, required this.city_name});

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        city_id: json["city_id"],
        type: json["type"],
        city_name: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        city_id: city_id,
        type: type,
        city_name: city_name,
      };
}

class RajaOngkir {
  final List<Results> results;

  RajaOngkir({
    required this.results,
  });

  factory RajaOngkir.fromJson(Map<String, dynamic> json) => RajaOngkir(
        results:
            List<Results>.from(json["results"].map((x) => Results.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class CityModel {
  final RajaOngkir rajaOngkir;

  CityModel({required this.rajaOngkir});

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      CityModel(rajaOngkir: RajaOngkir.fromJson(json["rajaongkir"]));

  Map<String, dynamic> toJson() => {"rajaongkir": rajaOngkir};
}
