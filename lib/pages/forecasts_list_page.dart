import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex/bloc/search_forecast_bloc/search_forecast_bloc.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

class ForecastsListPage extends StatelessWidget {
  final String city;

  const ForecastsListPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SearchForecastRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchForecastBloc(
                searchForecastRepository:
                    RepositoryProvider.of<SearchForecastRepository>(context)),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text('Прогноз. $city'),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_full_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back))
            ],
          ),
          body: _ForecastsListPage(city: city),
        ),
      ),
    );
  }
}

class _ForecastsListPage extends StatelessWidget {
  final String city;

  const _ForecastsListPage({required this.city});

  @override
  Widget build(BuildContext context) {
    final forecastByCity =
    context.select((SearchForecastBloc bloc) => bloc.state.forecastsByCity);
    context.read<SearchForecastBloc>().add(SearchForecastEvent(city));
    return Column(
      children: [
        //TODO первый элемент с минимальной температурой
        if (forecastByCity != null)
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final day = forecastByCity.forecasts[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(day.dtTxt),
                      Text('Темп: ${day.main.temp}'),
                      Text('Ощущ: ${day.main.feelsLike}'),
                      Text('Дв: ${day.main.pressure}')
                    ],
                  ),
                  leading: Hero(
                    tag: day.dtTxt,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(day.weather.icon),
                    ),
                  ),
                );
              },
              itemCount: forecastByCity.forecasts.length,
            ),
          ),
      ],
    );
  }
}
