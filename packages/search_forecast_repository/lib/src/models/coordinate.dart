class Coordinate {
  num lon;
  num lat;

  Coordinate({required this.lon, required this.lat});

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      Coordinate(lon: json['lon'], lat: json['lat']);

  Map<String, dynamic> toJson() => {'lon': lon, 'lat': lat};
}
