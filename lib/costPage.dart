// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter, unnecessary_string_interpolations, unused_local_variable
import 'dart:ffi';
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
import 'package:rajaongkir_flutter/cost_model.dart';

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
  late Future<CostModel> futureCostModel;

  @override
  void initState() {
    super.initState();
    futureCostModel = fetchCost();
  }

    Future<CostModel> fetchCost() async {
  final response =
      await http.post(Uri.parse('https://api.rajaongkir.com/starter/cost'),
          headers: {
            "key": 'b8ac5ecac1211b3307320b995623cb41',
          },
          body: ({
            "origin": widget.origin,
            "destination": widget.destination,
            "weight": widget.berat.toString(),
            "courier": widget.kurir,
          }));
  print(response.body);
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
  return CostModel.fromJson(responseJson);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: FutureBuilder<CostModel>(
              future: futureCostModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data!.rajaOngkir);
                  // print(snapshot.data!.rajaOngkir.results);
                  List<String> costName = snapshot.data!.rajaOngkir.results
                      .map((e) => e.name)
                      .toList();
                  List<Costs> costList =
                      snapshot.data!.rajaOngkir.results[0].costs;
                  return ListView.builder(
                    itemCount: costList.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text("${costList[index].service}"),
                        subtitle: Text("${costList[index].description}"),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Rp ${costList[index].cost[0].value.toString()}",
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text("${costList[index].cost[0].etd} Days")
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
