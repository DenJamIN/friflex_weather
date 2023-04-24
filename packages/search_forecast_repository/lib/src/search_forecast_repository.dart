import 'dart:convert';

import 'package:search_forecast_repository/search_forecast_repository.dart';

import 'network.dart';

//Репозиторий
class SearchForecastRepository {
  //Подключение к репозиторию
  Future<ForecastsByCity?> onSearch(String city) async {
    try {
      //Поулчаем ответ исходя из запроса ГЕТ
      final response = await Network(city: city).get();
      //Декодиурем джсонку из полученного ответа от сервера
      final jsonData = jsonDecode(response.body);
      //Создаём и возвращаем объект
      return ForecastsByCity.fromJson(jsonData);
    } catch (e) {
      //Если ловим ошибку, то возвращаем нулл
      print(e);
      return null;
    }
  }
}
