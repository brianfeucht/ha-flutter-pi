import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_flutter_app/models/weather_forecast.dart';

class WeatherForecastWidget extends StatelessWidget {
  const WeatherForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var forecast = context.watch<WeatherForecastModel>();

    return Card();
  }
}
