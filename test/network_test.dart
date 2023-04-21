import 'package:friflex/network/network.dart';
import 'package:test/test.dart';

void main() {
  test('Перенаправляющий конструктор', () {
    Network london = Network.withoutCountryCode('London');
    const expected = 'http://api.openweathermap.org/data/2.5/weather?q=London&APPID=a963eb6466f1df9b98dc313ed262ab91';
    expect(london.url.toString() == expected, true);
  });

  test('Код страны == null', () {
    Network london = Network(city: 'London', countryCode: null);
    const expected = 'http://api.openweathermap.org/data/2.5/weather?q=London&APPID=a963eb6466f1df9b98dc313ed262ab91';
    expect(london.url.toString() == expected, true);
  });

  test('Код страны валидный', () {
    Network london = Network(city: 'London', countryCode: 'us');
    const expected = 'http://api.openweathermap.org/data/2.5/weather?q=London%2Cus&APPID=a963eb6466f1df9b98dc313ed262ab91';
    expect(london.url.toString() == expected, true);
  });

  test('Код страны пустой', () {
    Network london = Network(city: 'London', countryCode: '  ');
    const expected = 'http://api.openweathermap.org/data/2.5/weather?q=London&APPID=a963eb6466f1df9b98dc313ed262ab91';
    expect(london.url.toString() == expected, true);
  });
}