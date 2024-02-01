// ignore_for_file: non_constant_identifier_names, unused_import, unnecessary_this, file_names
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Cost {
  final int value;
  final String etd;
  final String note;

  Cost({
    required this.value,
    required this.etd,
    required this.note,
  });

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        value: (json["value"]),
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}

class Costs {
  final String service;
  final String description;
  final List<Cost> cost;

  Costs({
    required this.service,
    required this.description,
    required this.cost,
  });

  factory Costs.fromJson(Map<String, dynamic> json) => Costs(
        service: json["service"],
        description: json["description"],
        cost: List<Cost>.from(json["cost"].map((x) => Cost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost.map((x) => x.toJson())),
      };
}

class Results {
  final String code;
  final String name;
  final List<Costs> costs;

  Results({required this.code, required this.name, required this.costs});

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        code: json["code"],
        name: json["name"],
        costs: List<Costs>.from(json["costs"].map((x) => Costs.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs.map((x) => x.toJson())),
      };
}

class OriginDetails {
  final String city_name;
  OriginDetails({
    required this.city_name,
  });

  factory OriginDetails.fromJson(Map<String, dynamic> json) => OriginDetails(
        city_name: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "city_name": city_name,
      };
}

class DestinationDetails {
  final String city_name;
  DestinationDetails({
    required this.city_name,
  });

  factory DestinationDetails.fromJson(Map<String, dynamic> json) =>
      DestinationDetails(
        city_name: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "city_name": city_name,
      };
}

class RajaOngkir {
  final OriginDetails originDetails;
  final DestinationDetails destinationDetails;
  final List<Results> results;

  RajaOngkir({
    required this.originDetails,
    required this.destinationDetails,
    required this.results,
  });

  factory RajaOngkir.fromJson(Map<String, dynamic> json) => RajaOngkir(
        originDetails: OriginDetails.fromJson(json["origin_details"]),
        destinationDetails:
            DestinationDetails.fromJson(json["destination_details"]),
        results:
            List<Results>.from(json["results"].map((x) => Results.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "origin_details": originDetails,
        "destination_details": destinationDetails,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class CostModel {
  final RajaOngkir rajaOngkir;

  CostModel({
    required this.rajaOngkir,
  });

  factory CostModel.fromJson(Map<String, dynamic> json) =>
      CostModel(rajaOngkir: RajaOngkir.fromJson(json["rajaongkir"]));

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaOngkir,
      };
}
