import 'dart:convert';

Coordinate coordinateModelJson(String str) =>
    Coordinate.fromJson(jsonDecode(str));

String coordinateModelToJson(Coordinate data) => jsonEncode(data.toJson());

class Coordinate {
  num lon;
  num lat;

  Coordinate({required this.lon, required this.lat});

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      Coordinate(lon: json['lon'], lat: json['lat']);

  Map<String, dynamic> toJson() => {'lon': lon, 'lat': lat};
}
