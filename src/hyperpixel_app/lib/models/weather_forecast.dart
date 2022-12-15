import 'package:flutter/foundation.dart';

class WeatherForecastModel extends ChangeNotifier {
  List<WeatherForcastDailyModel> _dailyForecasts = List.empty();

  set setDailyForecasts(List<WeatherForcastDailyModel> dailyForecasts) {
    _dailyForecasts = dailyForecasts;
  }

  get dailyForecasts {
    return _dailyForecasts;
  }
}

class WeatherForcastDailyModel {
  WeatherForcastDailyModel(int month, int day, double airTempHigh,
      double airTempLow, int precipProbability)
      : _day = day,
        _month = month,
        _airTempHigh = airTempHigh,
        _airTempLow = airTempLow,
        _precipProbability = precipProbability;

  int _day;
  int _month;
  double _airTempHigh;
  double _airTempLow;
  int _precipProbability;

  get day {
    return _day;
  }

  get month {
    return _month;
  }

  get airTempHigh {
    return _airTempHigh;
  }

  get airTempLog {
    return _airTempLow;
  }

  get precipProbability {
    return _precipProbability;
  }

  WeatherForcastDailyModel.fromJson(Map<String, dynamic> data)
      : _month = data["month_num"],
        _day = data["day_num"],
        _airTempHigh = data["air_temp_high"],
        _airTempLow = data["air_temp_low"],
        _precipProbability = data["precip_probability"] {}
}
