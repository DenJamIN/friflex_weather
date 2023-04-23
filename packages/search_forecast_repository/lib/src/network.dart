import 'package:http/http.dart' as http;

class Network {
  final String _scheme = 'http';
  final String _host = 'api.openweathermap.org';
  final String _path = '/data/2.5/forecast';
  final String city;
  final String? countryCode;
  final Map<String, dynamic> _queryParameters = {
    'q': '',
    'APPID': 'a963eb6466f1df9b98dc313ed262ab91'
  };

  late Uri url;

  Network({
    required this.city,
    required this.countryCode,
  }) {
    final isEmptyCountryCode = countryCode?.trim().isEmpty ?? true;
    final query = '$city${isEmptyCountryCode ? '' : ',$countryCode'}';
    _queryParameters.update('q', (value) => query);
    url = Uri(
      scheme: _scheme,
      host: _host,
      path: _path,
      queryParameters: _queryParameters,
    );
  }

  Network.withoutCountryCode(String city) : this(city: city, countryCode: null);

  Future<http.Response> get() {
    return http.get(Uri.parse(url.toString()));
  }
}