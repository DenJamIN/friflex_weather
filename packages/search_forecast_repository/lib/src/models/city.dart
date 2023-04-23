import 'coordinate.dart';

class City {
  int id;
  String name;
  Coordinate coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City(
      {required this.id,
      required this.name,
      required this.coord,
      required this.country,
      required this.population,
      required this.timezone,
      required this.sunrise,
      required this.sunset});

  factory City.fromJson(Map<String, dynamic> json) => City(
      id: json['id'],
      name: json['name'],
      coord: Coordinate.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'coord': coord,
        'country': country,
        'population': population,
        'timezone': timezone,
        'sunrise': sunrise,
        'sunset': sunset
      };
}
