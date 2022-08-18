import 'package:flutter/foundation.dart';
import 'dart:math';

enum PrecipitationType { none, rain, hail }

class CurrentWeatherModel extends ChangeNotifier {
  static const double msToMph = 2.2369362921;

  double _temp = double.nan;

  double _windAverage = double.nan;
  double _windGust = double.nan;
  int _windDirection = 0;

  double _humidity = double.nan;

  PrecipitationType _precipitationType = PrecipitationType.none;

  double get temperature {
    return _temp;
  }

  double get windAverage {
    return _windAverage;
  }

  double get windGust {
    return _windGust;
  }

  int get windDirection {
    return _windDirection;
  }

  double get humidity {
    return _humidity;
  }

  double get dewPoint {
    return _temp -
        (14.55 + 0.114 * _temp) * (1 - (0.01 * _humidity)) -
        pow(((2.5 + 0.007 * _temp) * (1 - (0.01 * _humidity))), 3) -
        (15.9 + 0.117 * _temp) * pow((1 - (0.01 * _humidity)), 14);
  }

  PrecipitationType get precipitationType {
    return _precipitationType;
  }

  void update(List<dynamic> obs) {
    _windAverage = obs[2] * msToMph;
    _windGust = obs[3] * msToMph;
    _windDirection = obs[4];
    _temp = obs[7];
    _humidity = obs[8];

    _precipitationType = PrecipitationType.values[obs[13]];

    notifyListeners();
  }
}
