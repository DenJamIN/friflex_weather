import 'package:http/http.dart' as http;

//Настраиваем запрос
class Network {
  final String _scheme = 'http';
  final String _host = 'api.openweathermap.org';
  final String _path = '/data/2.5/forecast';
  final String city;
  final Map<String, dynamic> _queryParameters = {
    'q': '',
    'APPID': 'a963eb6466f1df9b98dc313ed262ab91',
    'units': 'metric',
    'lang': 'ru'
  };

  late Uri url;

  Network({
    required this.city,
  }) {
    _queryParameters.update('q', (value) => city);
    url = Uri(
      scheme: _scheme,
      host: _host,
      path: _path,
      queryParameters: _queryParameters,
    );
  }

  //Подключение GET
  Future<http.Response> get() {
    return http.get(Uri.parse(url.toString()));
  }
}