import 'models.dart';

class Forecast {
  int visibility;
  num? pop;
  Weather weather;
  Temperature main;
  Wind wind;
  Clouds clouds;
  Rain? rain;
  Snow? snow;
  SystemInfo sys;
  String dtTxt;

  Forecast(
      {required this.visibility,
      required this.weather,
      required this.main,
      required this.wind,
      required this.clouds,
      required this.pop,
      required this.rain,
      required this.snow,
      required this.sys,
      required this.dtTxt});

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
      visibility: json['visibility'],
      pop: json['pop'],
      weather: Weather.fromJson(json['weather'].first),
      main: Temperature.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      sys: SystemInfo.fromJson(json['sys']),
      rain: json.containsKey('rain') ? Rain.fromJson(json['rain']) : null,
      snow: json.containsKey('snow') ? Snow.fromJson(json['snow']) : null,
      dtTxt: json['dt_txt']);

  Map<String, dynamic> toJson() => {
        'visibility': visibility,
        'pop': pop,
        'weather': weather,
        'main': main,
        'wind': wind,
        'clouds': clouds,
        'rain': rain,
        'snow': snow,
        'sys': sys,
        'dt_txt': dtTxt
      };
}
