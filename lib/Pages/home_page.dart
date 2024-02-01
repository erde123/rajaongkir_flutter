// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter, unused_local_variable, unnecessary_import, avoid_print

import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajaongkir_flutter/components/dropdown_courier.dart';
import 'package:rajaongkir_flutter/components/dropdown_city.dart';
import 'package:rajaongkir_flutter/Pages/cost_page.dart';
import 'package:rajaongkir_flutter/components/formatters/numeric_formatter.dart';
import 'package:rajaongkir_flutter/resources/providers/city_providers.dart';
import 'package:rajaongkir_flutter/resources/providers/cost_providers.dart';
import 'package:rajaongkir_flutter/resources/models/city_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cool_alert/cool_alert.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
  getState() => _HomePageState;
}

class _HomePageState extends ConsumerState<HomePage> {
  var kota_asal;
  var kota_tujuan;
  var berat;
  var kurir;
  var nama_kota_asal;
  var nama_kota_tujuan;
  var nama_kurir;
  refresh () {
    setState(() {
      
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cityData = ref.watch(cityDataProvider);
    return MaterialApp(
      title: "Raja Ongkir",
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: cityData.when(
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
                      nama_kota_asal = value;
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
                      nama_kota_tujuan = value;
                      print(kota_tujuan);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    //input hanya angka
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      NumericRangeFormatter(min: 1, max: 30000),
                    ],
                    decoration: InputDecoration(
                      labelText: "Berat Paket (gram)",
                      hintText: "Berat Paket",
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
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
                      nama_kurir = value;
                      print(kurir);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      if (kota_asal == null ||
                          kota_tujuan == null ||
                          berat == null ||
                          kurir == null) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          title: "Masih Ada yang Kosong",
                          text: "Harap diisi semuanya",
                        );
                      }
                      // else if (berat) {
                      // }
                      else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CostPage(
                              origin: kota_asal,
                              destination: kota_tujuan,
                              berat: berat,
                              kurir: kurir,
                              nama_kota_asal: nama_kota_asal,
                              nama_kota_tujuan: nama_kota_tujuan,
                              nama_kurir: nama_kurir,
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
                      }
                    },
                    child: Text("Cek Ongkir"),
                  )
                ],
              );
            },
            error: (error, s) => Column(
              children: [
                Text("Oops, something unexpected happen"),
                FloatingActionButton(
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    HomePage().getState().refresh();
                    
                  },
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
