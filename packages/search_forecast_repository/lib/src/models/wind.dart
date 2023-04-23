class Wind {
  num speed;
  int deg;
  num? gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) =>
      Wind(speed: json['speed'], deg: json['deg'], gust: json['temp_kf']);

  Map<String, dynamic> toJson() => {'speed': speed, 'deg': deg, 'gust': gust};
}
