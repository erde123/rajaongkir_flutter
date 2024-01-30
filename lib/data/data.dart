import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajaongkir_flutter/models/city_model.dart';
import 'package:rajaongkir_flutter/models/cost_model.dart';
import 'package:rajaongkir_flutter/services/services.dart';

final cityDataProvider = FutureProvider<CityModel>((ref) async {
  try {
    final cityService = ref.read(cityProvider);
    final cityData = await cityService.getCities();
    return cityData;
  } catch (e) {
    throw Exception("Error fetching cities: $e");
  }
});

final costDataProvider = FutureProvider.family<CostModel, List>((ref, query) async{
  try{
    final costService = ref.read(costProvider);
    final costData = await costService.getCosts(query[0], query[1], query[2], query[3]);
    return costData;
  } catch (e) {
    throw Exception("Error fetching costs: $e");
  }
});