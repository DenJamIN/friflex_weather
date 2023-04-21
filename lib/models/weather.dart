import 'dart:convert';

Weather weatherModelJson(String str) => Weather.fromJson(jsonDecode(str));

String weatherModelToJson(Weather data) => jsonEncode(data.toJson());

class Weather {
  int id;
  String main;
  String description;

  //TODO http://openweathermap.org/img/w/01d.png
  String icon;

  Weather(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'main': main, 'description': description, 'icon': icon};
}
