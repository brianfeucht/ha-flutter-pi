import 'package:flutter/foundation.dart';

enum ThermostatMode { off, heating, cooling, fan }

class ThermostatSettingsModel extends ChangeNotifier {
  ThermostatSettingsModel({this.onNewTempUpdate});

  int _currentTemp = 70;
  int _setTemp = 70;
  ThermostatMode _mode = ThermostatMode.off;

  final Function(ThermostatSettingsModel)? onNewTempUpdate;

  int get currentTemp {
    return _currentTemp;
  }

  int get setTemp {
    return _setTemp;
  }

  ThermostatMode get mode {
    return _mode;
  }

  void setNewTemp(int newTemp) {
    _setTemp = newTemp;

    notifyListeners();

    if (onNewTempUpdate != null) {
      onNewTempUpdate!(this);
    }
  }

  void receiveValuesFromUnit(
      int setTemp, int currentTemp, ThermostatMode mode) {
    _setTemp = setTemp;
    _currentTemp = currentTemp;
    _mode = mode;

    notifyListeners();
  }
}
