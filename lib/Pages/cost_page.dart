// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter, unnecessary_string_interpolations, unused_local_variable, sort_child_properties_last, avoid_print
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
import 'package:rajaongkir_flutter/components/formatters/currency/rupiah.dart';
import 'package:rajaongkir_flutter/main.dart';
import 'package:rajaongkir_flutter/resources/providers/cost_providers.dart';
import 'package:rajaongkir_flutter/resources/models/cost_model.dart';

class CostPage extends ConsumerStatefulWidget {
  final String origin;
  final String destination;
  final int berat;
  final String kurir;
  final String nama_kota_asal;
  final String nama_kota_tujuan;
  final String nama_kurir;

  const CostPage({
    Key? key,
    required this.origin,
    required this.destination,
    required this.berat,
    required this.kurir,
    required this.nama_kota_asal,
    required this.nama_kota_tujuan,
    required this.nama_kurir,
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
            },
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${widget.nama_kota_asal} ke ${widget.nama_kota_tujuan} @ ${(widget.berat / 1000).toString()} kg dengan ${(widget.nama_kurir)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              maxLines: 3,
            ),
          ),
        ),
        body: costData.when(
          data: (costData) {
            List<Costs> costList = costData.rajaOngkir.results[0].costs;
            if (costList.isEmpty) {
              return Center(
                child: Text("Tidak ada service yang tersedia"),
              );
            }
            return Column(
              children: [
                // Header Text
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     "${widget.nama_kota_asal} ke ${widget.nama_kota_tujuan} @ ${(widget.berat/1000).toString()} kg dengan ${(widget.nama_kurir)}",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //     ),
                //   ),
                // ),
                // List of Costs
                Expanded(
                  child: ListView.builder(
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
                              FormatCurrency.convertToIdr(
                                  costList[index].cost[0].value, 2),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text("${costList[index].cost[0].etd} Days")
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          error: (error, s) {
            print(error.toString());
            return Center(
              child: Text("Data tidak dapat ditemukan"),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
