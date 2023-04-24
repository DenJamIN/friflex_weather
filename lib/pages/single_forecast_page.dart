import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex/bloc/search_forecast_bloc/search_forecast_bloc.dart';
import 'package:friflex/pages/forecasts_list_page.dart';
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
            create: (context) =>
                SearchForecastBloc(
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
                onPressed: () =>
                    Navigator.push(
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
    return BlocListener<SearchForecastBloc, SearchForecastState>(
      listener: (context, state) async {
        if (state.forecastsByCity == null) {
          ScaffoldMessengerAlerts.showErrorMessage(
              context: context, text: 'Ошибка получения данных');
          await ErrorDialogAlert.showDialogAlert(context: context, body: 'Ошибка получения данных');
        }
      },
      child: Container(),
    );
  }
}

class ScaffoldMessengerAlerts {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorMessage(
      {required BuildContext context, required String text}) {
    return ScaffoldMessenger.of(context).showSnackBar(getErrorSnackBar(text));
  }

  static SnackBar getErrorSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      backgroundColor: Colors.redAccent,
      dismissDirection: DismissDirection.vertical,
    );
  }
}

enum DialogActions { cancel }

class ErrorDialogAlert {
  static Future<DialogActions> showDialogAlert({required BuildContext context,
    String title = 'Ошибка',
    required String body}) async {
    final action = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogActions.cancel);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                child: const Text('Отмена'),
              )
            ],
          );
        });
    return (action != null) ? action : DialogActions.cancel;
  }
}
