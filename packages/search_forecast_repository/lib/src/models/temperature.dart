class Temperature {
  static const kelvinT = 273.15;

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

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
      temp: convertToCAndRound(json['temp']),
      feelsLike: convertToCAndRound(json['feels_like']),
      tempMin: convertToCAndRound(json['temp_min']),
      tempMax: convertToCAndRound(json['temp_max']),
      pressure: json['pressure'],
      grndLevel: json['grnd_level'],
      seaLevel: json['sea_level'],
      tempKf: json['temp_kf'],
      humidity: json['humidity']);

  static num convertToCAndRound(dynamic value){
    return num.parse((value - kelvinT).toStringAsFixed(1));
  }

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
