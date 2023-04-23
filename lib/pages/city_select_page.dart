import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friflex/pages/single_forecast_page.dart';

class CitySelectPage extends StatelessWidget {
  CitySelectPage({super.key});

  late double widthDisplay;
  late double heightDisplay;

  String? city;

  @override
  Widget build(BuildContext context) {
    widthDisplay = MediaQuery.of(context).size.width;
    heightDisplay = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Прогноз погоды'))),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    const greetingsLabel = Text(
      'Ваше посещение мы тоже спрогнозировали!',
      textAlign: TextAlign.center,
    );
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [greetingsLabel, selectCityField(), confirmButton(context)],
      ),
    );
  }

  Widget selectCityField() {
    final edge = widthDisplay * 0.09;
    const decoration = InputDecoration(
        label: Text('Город'),
        labelStyle: TextStyle(fontSize: 30),
        hintText: 'Например: Калуга');

    return Padding(
      padding: EdgeInsets.only(left: edge, right: edge),
      child: TextField(
        decoration: decoration,
        onChanged: (String text) {
          city = text;
        },
      ),
    );
  }

  Widget confirmButton(BuildContext context) {
    const decoration = BoxDecoration(
        color: Color(0xff47A76A), borderRadius: BorderRadius.all(Radius.circular(40)));
    const text = Center(
        child: Text('Подтвердить', style: TextStyle(color: Colors.white, fontSize: 20)));

    return GestureDetector(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => SingleForecastPage(city: formatCity(city))))
      },
      child: Container(
        width: widthDisplay * 0.7,
        height: heightDisplay * 0.1,
        decoration: decoration,
        child: text,
      ),
    );
  }

  String formatCity(String? city) {
    city = city ?? '';
    final cityByDash = city.split('-');
    return cityByDash
        .map((e) => e[0].toUpperCase() + e.substring(1, e.length).toLowerCase())
        .join('-');
  }
}
