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
              .map<Forecast>((forecast) => Forecast.fromMap(forecast))
              .toList());

  Map<String, dynamic> toJson() =>
      {'cod': code, 'message': message, 'city': city, 'list': forecasts};
}
