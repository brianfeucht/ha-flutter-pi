import 'package:flutter/foundation.dart';

enum PrecipitationType { none, rain, hail }

class CurrentWeatherModel extends ChangeNotifier {
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

  PrecipitationType get precipitationType {
    return _precipitationType;
  }

  void update(List<dynamic> obs) {
    _windAverage = obs[2];
    _windGust = obs[3];
    _windDirection = obs[4];
    _temp = obs[7];
    _humidity = obs[8];

    _precipitationType = PrecipitationType.values[obs[13]];

    notifyListeners();
  }
}
