import 'models.dart';

class ForecastsByCity {
  String code;
  String message;
  City city;
  List<Forecast> forecasts;

  ForecastsByCity(
      {required this.code,
      required this.message,
      required this.city,
      required this.forecasts});

  //Достаём значения из джейсонки
  //Делаем фабричный констурктор, для того чтобы создать только один экземпляр
  factory ForecastsByCity.fromJson(Map<String, dynamic> json) =>
      ForecastsByCity(
          code: json['cod'],
          message: json['message'].toString(),
          city: City.fromJson(json['city']),
          forecasts: json['list']
          //Проходим каждый элемент и меняем его на объект Форкаст
              .map<Forecast>((forecast) => Forecast.fromJson(forecast))
          //Фильтруем все элементы
              .where(_isForecastBy3Days)
          //Коллект в список
              .toList());

  //прогноз на 3 дня без учета времени (То есть если 23.04 в 21:00 НЕ будут показаны прогнозы 26.04 до 21:00)
  static bool _isForecastBy3Days(Forecast forecast) {
    //Берем сегодняшнуюю дату
    final now = DateTime.now();
    //Берем дату из прогноза
    final forecastDateTime = DateTime.parse(forecast.dtTxt);
    //Затираем время у сегодняшней даты
    var lastDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
    //Добавляем два дня для получения прогнозов за три дня(включая сегодня)
    lastDate = lastDate.add(Duration(days: 2));
    //Затираем время у даты из прогноза
    final forecastDate = DateTime(
        forecastDateTime.year, forecastDateTime.month, forecastDateTime.day, 0);
    //Возвращаем тру, если разница между дат не отрицательная
    return !lastDate.difference(forecastDate).inDays.isNegative;
  }

  Map<String, dynamic> toJson() =>
      {'cod': code, 'message': message, 'city': city, 'list': forecasts};
}
