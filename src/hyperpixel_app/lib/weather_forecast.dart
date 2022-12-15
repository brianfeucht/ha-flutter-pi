import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:remote_flutter_app/models/weather_forecast.dart';

class WeatherForecast {
  final WeatherForecastModel _currentForecast = WeatherForecastModel();
  late Timer updateForecastTimer =
      Timer(const Duration(milliseconds: 10), () => retriveLatestForecast());

  // Contains a auth token.  I don't really care, but lets not make it obvious
  static String parkdaleForecastUrl = utf8.decode(base64.decode(
      "aHR0cHM6Ly9zd2Qud2VhdGhlcmZsb3cuY29tL3N3ZC9yZXN0L2JldHRlcl9mb3JlY2FzdD9zdGF0aW9uX2lkPTI2MTgzJnVuaXRzX3RlbXA9ZiZ1bml0c193aW5kPW1waCZ1bml0c19wcmVzc3VyZT1tYiZ1bml0c19wcmVjaXA9aW4mdW5pdHNfZGlzdGFuY2U9bWkmYXBpX2tleT1iNGM3YjhlZS02ODYwLTQwMWItYTI0ZS1hZjEyOWU5ZmI4MDY="));

  WeatherForecastModel get currentForecast {
    return _currentForecast;
  }

  void refreshForecast() {
    Timer.run(() => retriveLatestForecast());
  }

  Future<void> retriveLatestForecast() async {
    try {
      var res = await http.get(Uri.parse(parkdaleForecastUrl));
      dynamic tempestResp = json.decode(res.body);

      var dailyForecasts = <WeatherForcastDailyModel>[];

      for (int i = 0; i < tempestResp["forecast"]["daily"].length; i++) {
        var dailyForecast = WeatherForcastDailyModel.fromJson(
            tempestResp["forecast"]["daily"][i]);
        dailyForecasts.add(dailyForecast);
      }

      _currentForecast.setDailyForecasts = dailyForecasts;
    } catch (e) {
      print("Forecast retrieval failed ${e}");
    }
  }
}
