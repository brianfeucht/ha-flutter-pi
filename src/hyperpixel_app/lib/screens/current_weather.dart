import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/current_weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var currentWeather = context.watch<CurrentWeatherModel>();
    return Center(child: Text('Current: ${currentWeather.temperature} C'));
  }
}
