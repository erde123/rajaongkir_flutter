import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajaongkir_flutter/resources/models/city_model.dart';
import 'package:rajaongkir_flutter/resources/services/city_services.dart';

final cityProvider = Provider<CityApiService>((ref) => CityApiService());

final cityDataProvider = FutureProvider<CityModel>((ref) async {
  try {
    final cityService = ref.read(cityProvider);
    final cityData = await cityService.getCities();
    return cityData;
  } catch (e) {
    throw Exception("Error fetching cities: $e");
  }
});