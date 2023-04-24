import 'package:flutter/material.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

class ForecastsListPage extends StatelessWidget {
  final ForecastsByCity forecastByCity;
  late double width;
  late double height;

  ForecastsListPage({super.key, required this.forecastByCity});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Прогноз. ${forecastByCity.city.name}'),
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
                  title: SizedBox(
                    width: width * 0.9,
                    height: height * 0.1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        paddingText(day.dtTxt),
                        paddingText('Температура: ${day.main.temp}'),
                        paddingText('Ощущается: ${day.main.feelsLike}'),
                        paddingText('Давление: ${day.main.pressure}'),
                      ],
                    ),
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
            title: SizedBox(
              width: width * 0.9,
              height: height * 0.1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  paddingText(forecastColdest.dtTxt),
                  paddingText('Темп: ${forecastColdest.main.temp}'),
                  paddingText('Ощущ: ${forecastColdest.main.feelsLike}'),
                  paddingText('Дв: ${forecastColdest.main.pressure}'),
                ],
              ),
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

  Widget paddingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }
}
