import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex/bloc/search_forecast_bloc/search_forecast_bloc.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

class SingleForecastPage extends StatelessWidget {
  String city;

  SingleForecastPage({required this.city});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SearchForecastRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SearchForecastBloc(
                    searchForecastRepository:
                    RepositoryProvider.of<SearchForecastRepository>(context)),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text('Прогноз. $city'),
            actions: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.open_in_full_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))
            ],
          ),
          body: _SingleForecastPage(),
        ),
      ),
    );
  }
}

class _SingleForecastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forecastByCity = context.select((SearchForecastBloc bloc) =>
    bloc.state.forecastsByCity);
    return Column(children: [],);
  }

}