import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/current_weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  CurrentWeatherWidget({super.key});

  final List<String> cardinalDirections = [
    "N",
    "NNE",
    "NE",
    "ENE",
    "E",
    "ESE",
    "SE",
    "SSE",
    "S",
    "SSW",
    "SW",
    "WSW",
    "W",
    "WNW",
    "NW",
    "NNW"
  ];

  @override
  Widget build(BuildContext context) {
    var currentWeather = context.watch<CurrentWeatherModel>();
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          const ListTile(title: Text('Outside')),
          ListTile(
            leading: const Icon(Icons.device_thermostat_rounded),
            title: Text(
                '${convertToFriendlyString((currentWeather.temperature * 1.8000) + 32.00)}°F'),
            subtitle: Text(
                'Humidity: ${convertToFriendlyString(currentWeather.humidity)}% | Dewpoint: ${convertToFriendlyString((currentWeather.dewPoint * 1.8000) + 32.00)}°F'),
          ),
          ListTile(
              leading: const Icon(Icons.air_rounded),
              title: Text(
                  '${convertAngleToCardinal(currentWeather.windDirection)} ${convertToFriendlyString(currentWeather.windAverage)} mph'))
        ]));
  }

  String convertToFriendlyString(double value) {
    if (value == double.infinity || value == double.nan) {
      return "";
    }

    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  }

  String convertAngleToCardinal(int degrees) {
    int cardinalIndex = ((degrees / 22.5) + .5).floor() % 16;
    return cardinalDirections[cardinalIndex];
  }
}
