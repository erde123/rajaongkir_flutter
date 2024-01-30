// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter, unnecessary_string_interpolations, unused_local_variable
import 'dart:ffi';
import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
var kota_asal = "1";
var kota_tujuan = "2";
var berat = 1200;
var kurir = "jne";

void main() => runApp(const CostPage(
      origin: "1",
      destination: "2",
      berat: 1200,
      kurir: "jne",
    ));

class CostPage extends StatefulWidget {
  final String origin;
  final String destination;
  final int berat;
  final String kurir;

  const CostPage({
    Key? key,
    required this.origin,
    required this.destination,
    required this.berat,
    required this.kurir,
  }) : super(key: key);

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text("data")
        ),
      ),
    );
  }
}
