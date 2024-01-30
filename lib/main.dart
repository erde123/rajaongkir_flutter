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
import 'package:rajaongkir_flutter/costPage.dart';
import 'package:rajaongkir_flutter/data/data.dart';
import 'package:rajaongkir_flutter/models/city_model.dart';
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
      home: Scaffold(
        appBar: AppBar(),
        body: cityData.when(
          data: (cityData) {
            List<String> cityNames =
                cityData.rajaOngkir.results.map((e) => e.city_name).toList();
            return Column(
              children: [
                DropdownSearch<String>(
                  // asyncItems: (String? filter) => getData(filter),
                  popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      disabledItemFn: (String s) => s.startsWith('I'),
                      showSearchBox: true),
                  items: cityNames,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Pilih Kota Asal",
                      hintText: "Kota Asal",
                    ),
                  ),
                  onChanged: (value) {
                    for (int i = 0;
                        i < cityData.rajaOngkir.results.length - 1;
                        i++) {
                      if (value == cityData.rajaOngkir.results[i].city_name) {
                        kota_asal = cityData.rajaOngkir.results[i].city_id;
                        // print(kota_asal);
                      }
                    }
                  },
                  selectedItem: "",
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownSearch<String>(
                  // asyncItems: (String? filter) => getData(filter),
                  popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      disabledItemFn: (String s) => s.startsWith('I'),
                      showSearchBox: true),
                  items: cityNames,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Pilih Kota Tujuan",
                      hintText: "Kota Tujuan",
                    ),
                  ),
                  onChanged: (value) {
                    for (int i = 0;
                        i < cityData.rajaOngkir.results.length - 1;
                        i++) {
                      if (value == cityData.rajaOngkir.results[i].city_name) {
                        kota_asal = cityData.rajaOngkir.results[i].city_id;
                        // print(kota_asal);
                      }
                    }
                  },
                  selectedItem: "",
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  //input hanya angka
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Berat Paket (gram)",
                    hintText: "Berat Paket",
                  ),
                  onChanged: (text) {
                    berat = int.parse(text);
                    print(berat);
                  },
                ),
                DropdownSearch<String>(
                  // asyncItems: (String? filter) => getData(filter),
                  popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      disabledItemFn: (String s) => s.startsWith('I'),
                      showSearchBox: false),
                  items: ['JNE', 'POS INDONESIA', 'TIKI'],
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Pilih Kurir",
                      hintText: "Kurir",
                    ),
                  ),
                  onChanged: (value) {
                    if (value == 'JNE') {
                      kurir = 'jne';
                    } else if (value == 'POS INDONESIA') {
                      kurir = 'pos';
                    } else {
                      kurir = 'tiki';
                    }
                    print(kurir);
                  },
                  selectedItem: "",
                ),
                Builder(
                  builder: (BuildContext context) {
                    return TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CostPage(
                              origin: kota_asal,
                              destination: kota_tujuan,
                              berat: berat,
                              kurir: kurir,
                            ),
                          ),
                        );
                      },
                      child: Text("Cek Ongkir"),
                    );
                  },
                ),
              ],
            );
          },
          error: (error, s) => Text(error.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
