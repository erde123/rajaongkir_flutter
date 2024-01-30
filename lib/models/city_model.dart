class CityModel {
  Rajaongkir? rajaongkir;

  CityModel({this.rajaongkir});

  CityModel.fromJson(Map<String, dynamic> json) {
    rajaongkir = json['rajaongkir'] != null
        ? Rajaongkir.fromJson(json['rajaongkir'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rajaongkir != null) {
      data['rajaongkir'] = rajaongkir!.toJson();
    }
    return data;
  }
}

class Rajaongkir {
  List<Results>? results;

  Rajaongkir({this.results});

  Rajaongkir.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  Results(
      {this.cityId,
      this.provinceId,
      this.province,
      this.type,
      this.cityName,
      this.postalCode});

  Results.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    provinceId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['province_id'] = provinceId;
    data['province'] = province;
    data['type'] = type;
    data['city_name'] = cityName;
    data['postal_code'] = postalCode;
    return data;
  }
}