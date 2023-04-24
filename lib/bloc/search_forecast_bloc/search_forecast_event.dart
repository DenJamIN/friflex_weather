part of 'search_forecast_bloc.dart';

class SearchEvent {}

//Ивент для поиска города
class SearchForecastEvent extends SearchEvent {
  final String city;

  SearchForecastEvent(this.city);
}