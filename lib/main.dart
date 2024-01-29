// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter

import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rajaongkir_flutter/ProvinceModel.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rajaongkir_flutter/CityModel.dart';
import 'package:rajaongkir_flutter/costPage.dart';
import 'package:rajaongkir_flutter/cost_model.dart';

var kota_asal = "1";
var kota_tujuan = "2";
var berat = 1200;
var kurir = "jne";

Future<ProvinceModel> fetchProvince() async {
  final response = await http.get(
    Uri.parse('https://api.rajaongkir.com/starter/province'),
    headers: {
      "key": 'b8ac5ecac1211b3307320b995623cb41',
    },
  );
  // print(response.body);
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
  return ProvinceModel.fromJson(responseJson);
}

Future<CityModel> fetchCity() async {
  final response = await http.get(
    Uri.parse('https://api.rajaongkir.com/starter/city'),
    headers: {
      "key": 'b8ac5ecac1211b3307320b995623cb41',
    },
  );
  // print(response.body);
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
  return CityModel.fromJson(responseJson);
}

// Future<CostModel> fetchCost() async {
//   final response =
//       await http.post(Uri.parse('https://api.rajaongkir.com/starter/city'),
//           headers: {
//             "key": 'b8ac5ecac1211b3307320b995623cb41',
//           },
//           body: jsonEncode({
//             "origin": kota_asal,
//             "destination": kota_tujuan,
//             "weight": berat,
//             "courier": kurir,
//           }));
//   // print(response.body);
//   final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
//   return CostModel.fromJson(responseJson);
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<ProvinceModel> futureProvinceModel;
  late Future<CityModel> futureCityModel;
  // late Future<CostModel> futureCostModel;

  @override
  void initState() {
    super.initState();
    futureProvinceModel = fetchProvince();
    futureCityModel = fetchCity();
    // futureCostModel = fetchCost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Raja Ongkir",
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              FutureBuilder<CityModel>(
                future: futureCityModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data!.rajaOngkir);
                    // print(snapshot.data!.rajaOngkir.results);
                    var cityList = snapshot.data!.rajaOngkir.results;
                    List<String> cityNames =
                        cityList.map((e) => e.city_name).toList();
                    return DropdownSearch<String>(
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
                        for (int i = 0; i < cityList.length - 1; i++) {
                          if (value == cityList[i].city_name) {
                            kota_asal = cityList[i].city_id;
                            print(kota_asal);
                          }
                        }
                      },
                      selectedItem: "",
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
              FutureBuilder<CityModel>(
                future: futureCityModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var cityList = snapshot.data!.rajaOngkir.results;
                    List<String> cityNames = snapshot.data!.rajaOngkir.results
                        .map((e) => e.city_name)
                        .toList();
                    return DropdownSearch<String>(
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
                        for (int i = 0; i < cityList.length - 1; i++) {
                          if (value == cityList[i].city_name) {
                            kota_tujuan = cityList[i].city_id;
                            print(kota_tujuan);
                          }
                        }
                      },
                      selectedItem: "",
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
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
          ),
          // Provinsi

          // child: FutureBuilder<ProvinceModel>(
          //   future: futureProvinceModel,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       List<String> provinceNames = snapshot.data!.rajaOngkir.results
          //           .map((result) => result.province)
          //           .toList();
          //       return DropdownSearch<String>(
          //         // asyncItems: (String? filter) => getData(filter),
          //         popupProps: PopupProps.menu(
          //           showSelectedItems: true,
          //           disabledItemFn: (String s) => s.startsWith('I'),
          //           showSearchBox: true
          //         ),
          //         items: provinceNames,
          //         dropdownDecoratorProps: DropDownDecoratorProps(
          //           dropdownSearchDecoration: InputDecoration(
          //             labelText: "Pilih Provinsi Asal",
          //             hintText: "Provinsi Asal",
          //           ),
          //         ),
          //         onChanged: print,
          //         selectedItem: "",
          //       );
          //     } else if (snapshot.hasError) {
          //       return Text('${snapshot.error}');
          //     }

          //     // By default, show a loading spinner.
          //     return const CircularProgressIndicator();
          //   },
          // ),
        ),
      ),
    );
  }
}
