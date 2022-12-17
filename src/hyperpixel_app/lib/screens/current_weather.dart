import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/current_weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key});

  static final List<String> cardinalDirections = [
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
    return SizedBox(
        width: 250,
        height: 142,
        child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              ListTile(
                  title: Text(
                      '${convertToFriendlyString((currentWeather.temperature * 1.8000) + 32.00)}°F'),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Humidity: ${convertToFriendlyString(currentWeather.humidity)}%'),
                        Text(
                          'Dewpoint: ${convertToFriendlyString((currentWeather.dewPoint * 1.8000) + 32.00)}°F',
                        ),
                      ])),
              ListTile(
                  leading: const Icon(Icons.air_rounded),
                  title: Text(
                      '${convertAngleToCardinal(currentWeather.windDirection)} ${convertToFriendlyString(currentWeather.windAverage)} mph'))
            ])));
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
