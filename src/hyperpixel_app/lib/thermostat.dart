import 'package:remote_flutter_app/models/thermostat.dart';

class Thermostat {
  final ThermostatSettingsModel _currentSettings = ThermostatSettingsModel();

  ThermostatSettingsModel get currentSettings {
    return _currentSettings;
  }
}
