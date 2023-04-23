class Weather {
  int id;
  String main;
  String description;
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
      icon: 'http://openweathermap.org/img/w/${json['icon']}.png' );

  Map<String, dynamic> toJson() =>
      {'id': id, 'main': main, 'description': description, 'icon': icon};
}
