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

    return SizedBox(
        width: 476,
        height: 142,
        child: Card(
            child: Row(
          children: forecast.dailyForecasts
              .take(5)
              .map<Widget>((df) => Card(
                      child: Column(children: [
                    Text(toDayString(df)),
                    SizedBox(
                        height: 40, width: 85, child: Icon(df.conditionIcon)),
                    const SizedBox(height: verticalSpacing),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            df.precipTypeIcon,
                            size: 12,
                          ),
                          Text('${df.precipProbability}%')
                        ]),
                    const SizedBox(height: verticalSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_downward,
                          size: 12,
                        ),
                        Text('${df.airTempLow.truncate()}°F')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_upward, size: 12),
                        Text('${df.airTempHigh.truncate()}°F')
                      ],
                    ),
                    const SizedBox(height: verticalSpacing),
                  ])))
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
