// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter, unused_local_variable, unnecessary_import

import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajaongkir_flutter/Pages/cost_page.dart';
import 'package:rajaongkir_flutter/Pages/home_page.dart';
import 'package:rajaongkir_flutter/resources/providers/city_providers.dart';
import 'package:rajaongkir_flutter/resources/providers/cost_providers.dart';
import 'package:rajaongkir_flutter/resources/models/city_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

var kota_asal = "1";
var kota_tujuan = "2";
var berat = 1200;
var kurir = "jne";

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // late Future<CostModel> futureCostModel;

  @override
  void initState() {
    super.initState();
    // futureCostModel = fetchCost();
  }

  @override
  Widget build(BuildContext context) {
    final cityData = ref.watch(cityDataProvider);
    return MaterialApp(
      title: "Raja Ongkir",
      home: HomePage(),
    );
  }
}
