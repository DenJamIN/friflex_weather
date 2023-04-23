part of 'search_forecast_bloc.dart';

class SearchEvent {}

class SearchForecastEvent extends SearchEvent {
  final String city;

  SearchForecastEvent(this.city);
}