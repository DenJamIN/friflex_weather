import 'models.dart';

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
              .map<Forecast>((forecast) => Forecast.fromJson(forecast))
              .where(_isForecastBy3Days)
              .toList());

  static bool _isForecastBy3Days(Forecast forecast) {
    final now = DateTime.now();
    final forecastDateTime = DateTime.parse(forecast.dtTxt);
    var lastDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
    lastDate = lastDate.add(Duration(days: 2));
    final forecastDate = DateTime(
        forecastDateTime.year, forecastDateTime.month, forecastDateTime.day, 0);
    return !lastDate.difference(forecastDate).inDays.isNegative;
  }

  Map<String, dynamic> toJson() =>
      {'cod': code, 'message': message, 'city': city, 'list': forecasts};
}
