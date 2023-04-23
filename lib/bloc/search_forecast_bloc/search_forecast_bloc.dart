import 'package:bloc/bloc.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

part 'search_forecast_event.dart';

part 'search_forecast_state.dart';

class SearchForecastBloc
    extends Bloc<SearchForecastEvent, SearchForecastState> {
  SearchForecastBloc(
      {required SearchForecastRepository searchForecastRepository})
      : _searchUserRepository = searchForecastRepository,
        super(SearchForecastState()) {
    on<SearchForecastEvent>(_onSearch);
  }

  late final SearchForecastRepository _searchUserRepository;

  _onSearch(
      SearchForecastEvent event, Emitter<SearchForecastState> emit) async {
    final forecastsByCity = await _searchUserRepository.onSearch(event.city);
    emit(SearchForecastState(forecastsByCity: forecastsByCity));
  }
}
