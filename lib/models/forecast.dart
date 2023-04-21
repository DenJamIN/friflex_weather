import 'dart:convert';

import 'package:friflex/models/rain.dart';
import 'package:friflex/models/snow.dart';
import 'package:friflex/models/system_informations.dart';
import 'package:friflex/models/temperature.dart';
import 'package:friflex/models/weather.dart';
import 'package:friflex/models/wind.dart';

import 'clouds.dart';

Forecast forecastModelJson(String str) => Forecast.fromJson(jsonDecode(str));

String forecastModelToJson(Forecast data) => jsonEncode(data.toJson());

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

  factory Forecast.fromMap(Map<dynamic, dynamic> map) => Forecast(
      visibility: map['visibility'],
      pop: map['pop'],
      weather: Weather.fromJson(map['weather'].first),
      main: Temperature.fromJson(map['main']),
      wind: Wind.fromJson(map['wind']),
      clouds: Clouds.fromJson(map['clouds']),
      sys: SystemInfo.fromJson(map['sys']),
      rain: map.containsKey('rain') ? Rain.fromJson(map['rain']) : null,
      snow: map.containsKey('snow') ? Snow.fromJson(map['snow']) : null,
      dtTxt: map['dt_txt']);

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
