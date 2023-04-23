import 'dart:convert';

import 'package:search_forecast_repository/search_forecast_repository.dart';
import 'network.dart';

class SearchForecastRepository {
  Future<ForecastsByCity?> onSearch(String city) async {
    try {
      final response = await Network.withoutCountryCode(city).get();
      final jsonData = jsonDecode(response.body);
      return ForecastsByCity.fromJson(jsonData);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
