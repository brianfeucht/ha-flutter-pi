import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:remote_flutter_app/models/weather_forecast.dart';

class WeatherForecastWidget extends StatelessWidget {
  const WeatherForecastWidget({super.key});

  static const double verticalSpacing = 5;

  @override
  Widget build(BuildContext context) {
    var forecast = context.watch<WeatherForecastModel>();

    return Expanded(
        child: Card(
            child: Row(
      children: forecast.dailyForecasts
          .take(5)
          .map<Widget>((df) => Expanded(
                  child: Card(
                      child: Expanded(
                          child: Column(children: [
                Text(toDayString(df)),
                SizedBox(height: 40, child: Icon(df.conditionIcon)),
                const SizedBox(height: verticalSpacing),
                Text('${df.precipTypeUnicode}${df.precipProbability}%'),
                const SizedBox(height: verticalSpacing),
                Text('🠗${df.airTempLow.truncate()}°F'),
                Text('🠕${df.airTempHigh.truncate()}°F'),
              ])))))
          .toList(),
    )));
  }

  String toDayString(WeatherForcastDailyModel df) {
    var now = DateTime.now();
    var forecastDate = DateTime(now.year, df.month, df.day);

    if (forecastDate.day == now.day && forecastDate.month == now.month) {
      return "Today";
    }

    return '${DateFormat.E().format(forecastDate)} ${df.day}';
  }
}
