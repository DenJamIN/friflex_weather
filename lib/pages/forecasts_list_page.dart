import 'package:flutter/material.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

class ForecastsListPage extends StatelessWidget {
  //Неизменяемое поле с прогназами
  final ForecastsByCity forecastByCity;

  //Поля для определения размера экрана в дальнейшем
  late double width;
  late double height;

  //Конструктор с именованными опциональными параметрами
  ForecastsListPage({super.key, required this.forecastByCity});

  @override
  Widget build(BuildContext context) {
    //Инициализация полей
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    //Основная структура страницы
    return Scaffold(
      //Шапка
      appBar: AppBar(
        //Название шапки, используя название города
        title: Text('Прогноз. ${forecastByCity.city.name}'),
      ),
      body: Column(
        children: [
          //Прогноз с самой минимальной температурой
          getColdestForecast(forecastByCity),
          //Отступ фиксированный в 60 пикселей
          const SizedBox(height: 60),
          //Элемент позволяющий растянуть во весь экран дочерний
          Expanded(
            //Динамическое создание ЛистВью
            child: ListView.builder(
              itemBuilder: (context, index) {
                //Переменная в которой хранится конкретный прогноз
                final day = forecastByCity.forecasts[index];
                return ListTile(
                  //Область для ограничения диапазона дочернего элемента
                  title: SizedBox(
                    width: width * 0.9,
                    height: height * 0.1,
                    //Вложенный ЛистВью
                    child: ListView(
                      //Скролл горизонтальный
                      scrollDirection: Axis.horizontal,
                      children: [
                        paddingText(day.dtTxt),
                        paddingText('Температура: ${day.main.temp}'),
                        paddingText('Ощущается: ${day.main.feelsLike}'),
                        paddingText('Давление: ${day.main.pressure}'),
                      ],
                    ),
                  ),
                  //Иконка
                  leading: Hero(
                    //Метка, должна быть уникальной
                    tag: day.dtTxt,
                    //Пикча с визуальным статусом погоды
                    child: CircleAvatar(
                      //картинка из интернета
                      backgroundImage: NetworkImage(day.weather.icon),
                    ),
                  ),
                );
              },
              //количество элементов в списке
              itemCount: forecastByCity.forecasts.length,
            ),
          ),
        ],
      ),
    );
  }

  //Отображение прогноза с минимальной температурой
  Widget getColdestForecast(ForecastsByCity forecastByCity) {
    //Находим прогноз с минимальной температурой используя редьюс
    //Сравниваются два элемента списка, если первый меньше второго, то возвращаем 1ый
    final forecastColdest =
        forecastByCity.forecasts.reduce((a, b) => a.main.temp < b.main.temp ? a : b);

    return Column(
      children: [
        //Текст над строкой с описанием прогноза
        const Text(
          'Минимальная температура',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        //Описание прогноза
        Container(
          //Оформление контейнер, края - круглые, цвет - .. какой-то красивый цвет
          decoration: const BoxDecoration(
              color: Color(0xff5adcd9),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          //Вложенный листвью с горизонтальным скроллом
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

  //Виджет для экономии места в коде, просто возвращаем текст, отталкивающийся от других элементов по краям
  Widget paddingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }
}
