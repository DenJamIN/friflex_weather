import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex/bloc/search_forecast_bloc/search_forecast_bloc.dart';
import 'package:friflex/pages/forecasts_list_page.dart';
import 'package:search_forecast_repository/search_forecast_repository.dart';

import '../alerts/error_alert.dart';

class SingleForecastPage extends StatelessWidget {
  //Неизменяемое поле с название города
  final String city;

  //Конструктор с именованным опциональным параметром
  const SingleForecastPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    //Подключение к репозитори провайдеру
    return RepositoryProvider(
      //Создаем репозиторий
      create: (context) => SearchForecastRepository(),
      //В дочерний элемент передаём мультиблокпровайдер чтобы задавать несколько провайдер сразу
      child: MultiBlocProvider(
        providers: [
          //Блокпровайдер для обработки поиска прогнозов погоды
          BlocProvider(
            //создание блока
            create: (context) => SearchForecastBloc(
                searchForecastRepository: RepositoryProvider.of<SearchForecastRepository>(
                    context)), //передаем репозиторий
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
    //Создаем контент страницы
    return Scaffold(
      //Шапка
      appBar: AppBar(
        //Текст шапки, включающий в себя название города
        title: Text('Прогноз. $city'),
        //Кнопки на аппбаре
        actions: [
          //Если прогноз есть
          if (forecastByCity != null)
            //То создаем кнопку с иконкой
            IconButton(
                //При нажатии переводит пользователя на следующую страницу
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
      //Асинхронный листенер
        listener: (context, state) async {
          // Если возникает ошибка подключения к серверу то вызываем алерт
          if (state.forecastsByCity == null) {
            //Выводит скафолд с снэкбаром
            ErrorAlert.showErrorMessage(context: context);
            //Вызываем диалоговое окно с ошибкой
            await ErrorAlert.showDialogAlert(context: context);
          }
        },
        //Создаём билдер
        builder: (context, state) => Center(child: getContent(state.forecastsByCity)));
  }

  Widget getContent(ForecastsByCity? forecastsByCity) {
    //Если прогнозы есть, то
    if (forecastsByCity != null) {
      //Показываем самый свежий и актуальный прогноз на сегодня
      final forecast = forecastsByCity.forecasts.first;
      return Column(
        children: [
          //Надпись с названием города и временем
          Text(
            'Погода в городе ${forecastsByCity.city.name} сейчас (${forecast.dtTxt})',
            style: const TextStyle(fontSize: 24),
            //Текст централизуется при переносе
            textAlign: TextAlign.center,
          ),
          //Вывод статуса погоды
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
              //Вывод информации об объеме осадков
              if (forecast.rain != null)
                'Объём осадков дождя: ${forecast.rain.toString()}',
              //Вывод информации об объеме осадков
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
    }
    //Если прогнозов нет - то ничего не выводим
    else {
      return Container();
    }
  }

  Widget weatherStatus(Forecast forecast) {
    return SizedBox(
      height: 100,
      width: 600,
      //Все элементы располагаются в строке
      child: Row(
        children: [
          //Текст
          const Text(
            'Статус погоды: ',
            style: TextStyle(fontSize: 18),
          ),
          //Картинка из интернета
          Image.network(
            forecast.weather.icon,
            scale: 0.6,
          ),
          //Описание статуса
          Text(
            forecast.weather.description.toUpperCase(),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

//Виджет который представляет из себя Вкладку со списком соответствующих характеристик
class TabView extends StatelessWidget {
  //Навзание вкладки
  final String tabName;
  //Цвет вкладки
  final Color tabColor;
  //Элементы в списке
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
        //Название вкладки
        Text(
          tabName,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        //Содержимое вкладки
        Container(
          height: height * 0.2,
          width: width * 0.8,
          //Декорация: цвет красивый, крас закруглены
          decoration: BoxDecoration(
              color: tabColor,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          //Динамический лист билдер из переданных значений
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
