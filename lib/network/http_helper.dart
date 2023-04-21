import 'dart:convert';

import 'package:http/http.dart';

import '../models/forecasts_by_city.dart';
import 'network.dart';

class WeatherHttp {
  Future<ForecastsByCity> get(String city) async {
    final response = await Network.withoutCountryCode(city).get();
    return _convertJson(response);
  }

  ForecastsByCity _convertJson(Response response) {
    final jsonData = jsonDecode(response.body);
    return ForecastsByCity.fromJson(jsonData);
  }
}
