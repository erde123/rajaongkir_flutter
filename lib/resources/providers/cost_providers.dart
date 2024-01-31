// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajaongkir_flutter/resources/models/cost_model.dart';
import 'package:rajaongkir_flutter/resources/services/cost_services.dart';

final costProvider = Provider<CostApiService>((ref) => CostApiService());

final costDataProvider =
    FutureProvider.family<CostModel, Map<String, dynamic>>((ref, query) async {
  try {
    final costService = ref.read(costProvider);
    final costData = await costService.getCosts(
      query["origin"],
      query["destination"],
      query["berat"],
      query["kurir"],
    );
    print(costData.toString());
    return costData;
  } catch (e) {
    throw Exception("Error fetching costs: $e");
  }
});
