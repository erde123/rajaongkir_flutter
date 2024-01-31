// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter, unused_local_variable, unnecessary_import, avoid_print

import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajaongkir_flutter/components/DropDownCourier.dart';
import 'package:rajaongkir_flutter/components/DropDownCity.dart';
import 'package:rajaongkir_flutter/Pages/cost_page.dart';
import 'package:rajaongkir_flutter/resources/providers/city_providers.dart';
import 'package:rajaongkir_flutter/resources/providers/cost_providers.dart';
import 'package:rajaongkir_flutter/resources/models/city_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

var kota_asal = "1";
var kota_tujuan = "2";
var berat = 1200;
var kurir = "jne";

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
                // DropDown Kota Asal
                DropDownCity(
                  item: cityNames,
                  hintText: "Kota Asal",
                  labelText: "Pilih Kota Asal",
                  onChanged: (value) {
                    for (int i = 0;
                        i < cityData.rajaOngkir.results.length - 1;
                        i++) {
                      if (value == cityData.rajaOngkir.results[i].city_name) {
                        kota_asal = cityData.rajaOngkir.results[i].city_id;
                      }
                    }
                    print(kota_asal);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                // DropDown Kota Tujuan
                DropDownCity(
                  item: cityNames,
                  hintText: "Kota Tujuan",
                  labelText: "Pilih Kota Tujuan",
                  onChanged: (value) {
                    for (int i = 0;
                        i < cityData.rajaOngkir.results.length - 1;
                        i++) {
                      if (value == cityData.rajaOngkir.results[i].city_name) {
                        kota_tujuan = cityData.rajaOngkir.results[i].city_id;
                      }
                    }
                    print(kota_tujuan);
                  },
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
                // DropDown Kurir
                DropDownCourier(
                  item: ['JNE', 'POS INDONESIA', 'TIKI'],
                  hintText: "Pilih Jenis Kurir",
                  labelText: "Jenis Kurir",
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
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
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
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CostPage(
                    //       origin: kota_asal,
                    //       destination: kota_tujuan,
                    //       berat: berat,
                    //       kurir: kurir,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Text("Cek Ongkir"),
                )
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
