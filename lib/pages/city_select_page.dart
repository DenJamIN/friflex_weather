import 'package:flutter/material.dart';
import 'package:friflex/pages/single_forecast_page.dart';

class CitySelectPage extends StatelessWidget {
  CitySelectPage({super.key});

  //Поля для дальнейшего определения параметров длины и ширины экрана
  late double width;
  late double height;

  //Нуллейбл поле
  String? city;

  @override
  Widget build(BuildContext context) {
    //Инициализация полей
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    //Основная структура страницы
    return Scaffold(
      //Шапка страницы
      appBar: AppBar(
        //Название страницы
        title: const Center(
          child: Text('Прогноз погоды'),
        ),
      ),
      //Тело страницы
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    //поле типа Виджет, с приветственным текстом
    const greetingsLabel = Text(
      'Ваше посещение мы тоже спрогнозировали!',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
    );

    return Padding(
      //Отступы по краям в 20 пикселей
      padding: const EdgeInsets.all(20.0),
      //Элементы расположенные в колонки
      child: Column(
        //Отступы между всеми элементами равномерно во весь экран
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          greetingsLabel,
          selectCityField(),
          confirmButton(context),
        ],
      ),
    );
  }

  //Поле для ввода города
  Widget selectCityField() {
    final edge = width * 0.09;

    //Поле типа InputDecoration
    const decoration = InputDecoration(
        //Надпись над полем
        label: Text('Город'),
        //Шрифт
        labelStyle: TextStyle(fontSize: 30),
        //Серый текст в поле, который пропадает при нажатии
        hintText: 'Например: Калуга');

    return Padding(
      padding: EdgeInsets.only(left: edge, right: edge),
      child: TextField(
        decoration: decoration,
        //При изменении значения поля в переменную city записывается значения из поля
        onChanged: (String text) {
          city = text;
        },
      ),
    );
  }

  //Кнопка подтверждения
  Widget confirmButton(BuildContext context) {
    //Декорация кнопки: цвет, округление
    const decoration = BoxDecoration(
        color: Color(0xff47A76A), borderRadius: BorderRadius.all(Radius.circular(40)));
    //Текст кнопки
    const text = Center(
        child: Text('Подтвердить', style: TextStyle(color: Colors.white, fontSize: 20)));

    //Крутой инструмент для обработки действий пользователя
    return GestureDetector(
      onTap: () => {
        //Переход на другую страницу
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => SingleForecastPage(city: formatCity(city))))
      },
      //Создаем оболочку кнопки
      child: Container(
        width: width * 0.7,
        height: height * 0.1,
        decoration: decoration,
        child: text,
      ),
    );
  }

  //Обработка ввода пользователя, просто делаем название города с заглавной буквы
  String formatCity(String? city) {
    city = city ?? '';
    //Если город пишется через - в таком случае каждое его слово должно начинаться с заглавной
    final cityByDash = city.split('-');
    return cityByDash
        .map((e) => e[0].toUpperCase() + e.substring(1, e.length).toLowerCase())
        .join('-');
  }
}
