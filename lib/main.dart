// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter

import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late Future<CostModel> futureCostModel;

  @override
  void initState() {
    super.initState();
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
