import 'package:flutter/foundation.dart';

enum ThermostatMode { off, heating, cooling, fan, auto }

enum FanSpeed { auto, quiet, one, two, three, four }

class ThermostatSettingsModel extends ChangeNotifier {
  ThermostatSettingsModel({this.onModelUpdate});

  int _currentTemp = 70;
  int _setTemp = 70;
  ThermostatMode _mode = ThermostatMode.off;
  FanSpeed _fanSpeed = FanSpeed.auto;

  void Function(ThermostatSettingsModel)? onModelUpdate;

  int get currentTemp {
    return _currentTemp;
  }

  int get setTemp {
    return _setTemp;
  }

  ThermostatMode get mode {
    return _mode;
  }

  FanSpeed get fanSpeed {
    return _fanSpeed;
  }

  void setNewTemp(int newTemp) {
    if (newTemp > 80 || newTemp < 55 || newTemp == _setTemp) {
      return;
    }

    _setTemp = newTemp;

    notifyListeners();

    if (onModelUpdate != null) {
      onModelUpdate!(this);
    }
  }

  void setNewMode(ThermostatMode mode) {
    if (mode == _mode) {
      return;
    }

    _mode = mode;

    notifyListeners();

    if (onModelUpdate != null) {
      onModelUpdate!(this);
    }
  }

  void setFanSpeed(FanSpeed fanSpeed) {
    if (fanSpeed == _fanSpeed) {
      return;
    }
    _fanSpeed = fanSpeed;

    notifyListeners();

    if (onModelUpdate != null) {
      onModelUpdate!(this);
    }
  }

  void receiveValuesFromUnit(
      int setTemp, int currentTemp, ThermostatMode mode, FanSpeed fanSpeed) {
    _setTemp = setTemp;
    _currentTemp = currentTemp;
    _mode = mode;
    _fanSpeed = fanSpeed;

    notifyListeners();
  }
}
