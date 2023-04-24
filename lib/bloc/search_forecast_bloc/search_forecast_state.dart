part of 'search_forecast_bloc.dart';

//Состояние с объектом, хранящим всю информацию о прогнозе
class SearchForecastState {
  final ForecastsByCity? forecastsByCity;

  SearchForecastState({
    this.forecastsByCity,
  });
}
