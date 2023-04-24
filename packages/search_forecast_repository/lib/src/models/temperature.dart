class Temperature {
  num temp;
  num feelsLike;
  num tempMin;
  num tempMax;
  int pressure;
  int? grndLevel;
  int? seaLevel;
  num? tempKf;
  int? humidity;

  Temperature(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.grndLevel,
      required this.seaLevel,
      required this.tempKf,
      required this.humidity});

  //Достаём значения из джейсонки
  //Делаем фабричный констурктор, для того чтобы создать только один экземпляр
  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      grndLevel: json['grnd_level'],
      seaLevel: json['sea_level'],
      tempKf: json['temp_kf'],
      humidity: json['humidity']);

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'grnd_level': grndLevel,
        'sea_level': seaLevel,
        'temp_kf': tempKf,
        'humidity': humidity
      };
}
