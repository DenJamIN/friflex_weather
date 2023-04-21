import 'dart:convert';

import 'city.dart';
import 'forecast.dart';

ForecastsByCity forecastsByCityModelJson(String str) =>
    ForecastsByCity.fromJson(jsonDecode(str));

String forecastsByCityModelToJson(ForecastsByCity data) =>
    jsonEncode(data.toJson());

class ForecastsByCity {
  String code;
  String message;
  City city;
  List<Forecast> forecasts;

  ForecastsByCity(
      {required this.code,
      required this.message,
      required this.city,
      required this.forecasts});

  factory ForecastsByCity.fromJson(Map<String, dynamic> json) =>
      ForecastsByCity(
          code: json['cod'],
          message: json['message'].toString(),
          city: City.fromJson(json['city']),
          forecasts: json['list']
              .map<Forecast>((forecast) => Forecast.fromMap(forecast))
              .toList());

  Map<String, dynamic> toJson() =>
      {'cod': code, 'message': message, 'city': city, 'list': forecasts};
}
