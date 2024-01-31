// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter, unnecessary_string_interpolations, unused_local_variable, sort_child_properties_last
import 'dart:ffi';
import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rajaongkir_flutter/Pages/home_page.dart';
import 'package:rajaongkir_flutter/resources/providers/cost_providers.dart';
import 'package:rajaongkir_flutter/resources/models/cost_model.dart';

class CostPage extends ConsumerStatefulWidget {
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
  ConsumerState<CostPage> createState() => _CostPageState();
}

class _CostPageState extends ConsumerState<CostPage> {
  late Map<String, dynamic> query;

  @override
  void initState() {
    super.initState();
    query = {
      'origin': widget.origin,
      'destination': widget.destination,
      'berat': widget.berat.toString(),
      'kurir': widget.kurir,
    };
  }

  @override
  Widget build(BuildContext context) {
    final costData = ref.watch(costDataProvider(query));
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_sharp,
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => HomePage(),
              //   ),
              // );
            },
          ),
        ),
        body: costData.when(
          data: (costData) {
            List<String> costNames =
                costData.rajaOngkir.results.map((e) => e.name).toList();
            List<Costs> costList = costData.rajaOngkir.results[0].costs;
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
