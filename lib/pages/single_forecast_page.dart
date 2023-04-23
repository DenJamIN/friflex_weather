import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex/bloc/search_forecast_bloc/search_forecast_bloc.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

class SingleForecastPage extends StatelessWidget {
  final String city;

  const SingleForecastPage({super.key, required this.city});

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
          body: _SingleForecastPage(city: city),
        ),
      ),
    );
  }
}

class _SingleForecastPage extends StatelessWidget {
  final String city;

  const _SingleForecastPage({required this.city});

  @override
  Widget build(BuildContext context) {
    final forecastByCity =
        context.select((SearchForecastBloc bloc) => bloc.state.forecastsByCity);
    context.read<SearchForecastBloc>().add(SearchForecastEvent(city));
    return Column(
      children: [
        if (forecastByCity != null)
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final day = forecastByCity.forecasts[index];
                return ListTile(
                  title: Text(day.dtTxt),
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
