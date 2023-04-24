class Coordinate {
  num lon;
  num lat;

  Coordinate({required this.lon, required this.lat});

  //Достаём значения из джейсонки
  //Делаем фабричный констурктор, для того чтобы создать только один экземпляр
  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      Coordinate(lon: json['lon'], lat: json['lat']);

  Map<String, dynamic> toJson() => {'lon': lon, 'lat': lat};
}
