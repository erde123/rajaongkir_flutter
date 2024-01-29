// ignore_for_file: non_constant_identifier_names, unused_import, unnecessary_this, file_names

import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Results {
  final String province_id;
  final String province;

  Results({
    required this.province_id,
    required this.province,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        province_id: json["province_id"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": province_id,
        "province": province,
      };
}

// class Status {
//   Int? code;
//   String? description;

//   Status({this.code, this.description});

//   factory Status.fromJson(Map<String, dynamic> json) =>
//       Status(code: json["code"], description: json["description"]);

//   Map<String, dynamic> toJson() => {"code": code, "description": description};
// }

// class Query {
//   String? id;

//   Query({this.id});

//   factory Query.fromJson(Map<String, dynamic> json) => Query(id: json["id"]);

//   Map<String, dynamic> toJson() => {"id": id};
// }

class RajaOngkir {
  // final Query query;
  // final Status status;
  final List<Results> results;

  RajaOngkir({
    // required this.status,
    required this.results,
  });

  factory RajaOngkir.fromJson(Map<String, dynamic> json) => RajaOngkir(
        // query: Query.fromJson(json["query"]),
        // status: Status.fromJson(json["status"]),
        results:
            List<Results>.from(json["results"].map((x) => Results.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "query": query,
        // "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ProvinceModel {
  final RajaOngkir rajaOngkir;

  ProvinceModel({required this.rajaOngkir});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>
      ProvinceModel(rajaOngkir: RajaOngkir.fromJson(json["rajaongkir"]));

  Map<String, dynamic> toJson() => {"rajaongkir": rajaOngkir};
}
