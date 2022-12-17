// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherForecastModel extends ChangeNotifier {
  List<WeatherForcastDailyModel> _dailyForecasts = List.empty();

  set setDailyForecasts(List<WeatherForcastDailyModel> dailyForecasts) {
    _dailyForecasts = dailyForecasts;
    notifyListeners();
  }

  List<WeatherForcastDailyModel> get dailyForecasts {
    return _dailyForecasts;
  }
}

enum ConditionIcon {
  clear_day,
  clear_night,
  cloudy,
  foggy,
  partly_cloudy_day,
  partly_cloudy_night,
  possibly_rainy_day,
  possibly_rainy_night,
  possibly_sleet_day,
  possibly_sleet_night,
  possibly_snow_day,
  possibly_snow_night,
  possibly_thunderstorm_day,
  possibly_thunderstorm_night,
  rainy,
  sleet,
  snow,
  thunderstorm,
  windy,
}

enum PrecipType {
  rain,
  snow,
  sleet,
  storm,
}

class WeatherForcastDailyModel {
  final int _day;
  int _month;
  double _airTempHigh;
  double _airTempLow;
  int _precipProbability;
  PrecipType _precipType;
  ConditionIcon _conditionIcon;

  int get day {
    return _day;
  }

  int get month {
    return _month;
  }

  double get airTempHigh {
    return _airTempHigh;
  }

  double get airTempLow {
    return _airTempLow;
  }

  int get precipProbability {
    return _precipProbability;
  }

  PrecipType get precipType {
    return _precipType;
  }

  String get precipTypeUnicode {
    switch (_precipType) {
      case PrecipType.rain:
        return "💧";
      case PrecipType.snow:
        return "❄";
      case PrecipType.sleet:
        return "🧊";
      case PrecipType.storm:
        return "⚡";
    }
  }

  IconData? get conditionIcon {
    switch (_conditionIcon) {
      case ConditionIcon.clear_day:
        return WeatherIcons.day_sunny;
      case ConditionIcon.clear_night:
        return WeatherIcons.night_clear;
      case ConditionIcon.cloudy:
        return WeatherIcons.cloudy;
      case ConditionIcon.foggy:
        return WeatherIcons.fog;
      case ConditionIcon.partly_cloudy_day:
        return WeatherIcons.day_cloudy;
      case ConditionIcon.partly_cloudy_night:
        return WeatherIcons.night_alt_partly_cloudy;
      case ConditionIcon.possibly_rainy_day:
        return WeatherIcons.day_showers;
      case ConditionIcon.possibly_rainy_night:
        return WeatherIcons.night_alt_showers;
      case ConditionIcon.possibly_sleet_day:
        return WeatherIcons.day_sleet;
      case ConditionIcon.possibly_sleet_night:
        return WeatherIcons.night_alt_sleet;
      case ConditionIcon.possibly_snow_day:
        return WeatherIcons.day_snow;
      case ConditionIcon.possibly_snow_night:
        return WeatherIcons.night_alt_snow;
      case ConditionIcon.possibly_thunderstorm_day:
        return WeatherIcons.day_thunderstorm;
      case ConditionIcon.possibly_thunderstorm_night:
        return WeatherIcons.night_alt_thunderstorm;
      case ConditionIcon.rainy:
        return WeatherIcons.rain;
      case ConditionIcon.sleet:
        return WeatherIcons.sleet;
      case ConditionIcon.snow:
        return WeatherIcons.snow;
      case ConditionIcon.thunderstorm:
        return WeatherIcons.thunderstorm;
      case ConditionIcon.windy:
        return WeatherIcons.wind;
    }
  }

  WeatherForcastDailyModel.fromJson(Map<String, dynamic> data)
      : _month = data["month_num"],
        _day = data["day_num"],
        _airTempHigh = data["air_temp_high"],
        _airTempLow = data["air_temp_low"],
        _precipProbability = data["precip_probability"],
        _precipType = PrecipType.values.byName(data["precip_type"]),
        _conditionIcon =
            ConditionIcon.values.byName(data["icon"].replaceAll('-', '_'));
}
