import 'package:bloc/bloc.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

part 'search_forecast_event.dart';

part 'search_forecast_state.dart';

class SearchForecastBloc
    extends Bloc<SearchForecastEvent, SearchForecastState> {
  SearchForecastBloc(
      {required SearchForecastRepository searchForecastRepository})
  //инициализируем состояние и репозиторий через список инициализации
      : _searchUserRepository = searchForecastRepository,
        super(SearchForecastState()) {
    //декларируем ивенты
    on<SearchForecastEvent>(_onSearch);
  }

  //Поле репозитория
  late final SearchForecastRepository _searchUserRepository;

  _onSearch(
      SearchForecastEvent event, Emitter<SearchForecastState> emit) async {
    //Инициализация поля репозитория
    final forecastsByCity = await _searchUserRepository.onSearch(event.city);
    //функция для изменения состояния
    emit(SearchForecastState(forecastsByCity: forecastsByCity));
  }
}
