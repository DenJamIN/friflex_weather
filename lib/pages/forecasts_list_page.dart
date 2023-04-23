import 'package:flutter/material.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

class ForecastsListPage extends StatelessWidget {
  final ForecastsByCity forecastByCity;

  const ForecastsListPage({super.key, required this.forecastByCity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Прогноз. ${forecastByCity.city}'),
      ),
      body: Column(
        children: [
          getColdestForecast(forecastByCity),
          const SizedBox(height: 60),
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
      ),
    );
  }

  Widget getColdestForecast(ForecastsByCity forecastByCity) {
    final forecastColdest =
        forecastByCity.forecasts.reduce((a, b) => a.main.temp < b.main.temp ? a : b);

    return Column(
      children: [
        const Text(
          'Минимальная температура',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Container(
          decoration: const BoxDecoration(
              color: Color(0xff5adcd9),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(forecastColdest.dtTxt),
                Text('Темп: ${forecastColdest.main.temp}'),
                Text('Ощущ: ${forecastColdest.main.feelsLike}'),
                Text('Дв: ${forecastColdest.main.pressure}')
              ],
            ),
            leading: Hero(
              tag: 'coldestTemp',
              child: CircleAvatar(
                backgroundImage: NetworkImage(forecastColdest.weather.icon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
