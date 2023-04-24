import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex/bloc/search_forecast_bloc/search_forecast_bloc.dart';
import 'package:friflex/pages/forecasts_list_page.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

import '../alerts/error_alert.dart';

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
        child: _SingleForecastPage(city: city),
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Прогноз. $city'),
        actions: [
          if (forecastByCity != null)
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            ForecastsListPage(forecastByCity: forecastByCity))),
                icon: const Icon(Icons.open_in_full_outlined))
        ],
      ),
      body: forecastInfo(),
    );
  }

  Widget forecastInfo() {
    return BlocConsumer<SearchForecastBloc, SearchForecastState>(
        listener: (context, state) async {
          if (state.forecastsByCity == null) {
            ErrorAlert.showErrorMessage(context: context);
            await ErrorAlert.showDialogAlert(context: context);
          }
        },
        builder: (context, state) => Center(child: getContent(state.forecastsByCity)));
  }

  Widget getContent(ForecastsByCity? forecastsByCity) {
    if (forecastsByCity != null) {
      final forecast = forecastsByCity.forecasts.first;
      return Column(
        children: [
          Text(
            'Погода в городе ${forecastsByCity.city.name} сейчас (${forecast.dtTxt})',
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          weatherStatus(forecast),
          TabView(
            tabColor: const Color(0xffffca8e),
            tabName: 'Температура',
            tabValues: [
              'Температура: ${forecast.main.temp.toString()}',
              'Ощущается: ${forecast.main.feelsLike.toString()}',
              'Давление: ${forecast.main.pressure.toString()}',
              'Влажность: ${forecast.main.humidity.toString()}',
            ],
          ),
          TabView(
            tabColor: const Color(0xff87CEFA),
            tabName: 'Облачность',
            tabValues: [
              'Процентная облачность: ${forecast.clouds.all.toString()}%',
              if (forecast.rain != null)
                'Объём осадков дождя: ${forecast.rain.toString()}',
              if (forecast.snow != null)
                'Объём осадков снега: ${forecast.rain.toString()}',
            ],
          ),
          TabView(
            tabColor: const Color(0xff00BFFF),
            tabName: 'Ветер',
            tabValues: [
              'Скорость ветра: ${forecast.wind.speed.toString()}м/с',
              'Направление ветра в градусах: ${forecast.wind.deg.toString()}',
              if (forecast.wind.gust != null)
                'Порыв ветра: ${forecast.wind.gust.toString()}м/с',
            ],
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget weatherStatus(Forecast forecast) {
    return SizedBox(
      height: 100,
      width: 600,
      child: Row(
        children: [
          const Text(
            'Статус погоды: ',
            style: TextStyle(fontSize: 18),
          ),
          Image.network(
            forecast.weather.icon,
            scale: 0.6,
          ),
          Text(
            forecast.weather.description.toUpperCase(),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class TabView extends StatelessWidget {
  final String tabName;
  final Color tabColor;
  final List<String> tabValues;

  const TabView(
      {super.key,
      required this.tabName,
      required this.tabValues,
      required this.tabColor});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text(
          tabName,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Container(
          height: height * 0.2,
          width: width * 0.8,
          decoration: const BoxDecoration(
              color: Color(0xffffca8e),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ListView.builder(
            itemBuilder: (context, index) {
              final value = tabValues[index];
              return ListTile(
                title: Text(value),
              );
            },
            itemCount: tabValues.length,
          ),
        )
      ],
    );
  }
}
