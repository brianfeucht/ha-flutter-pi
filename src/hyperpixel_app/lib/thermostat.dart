import 'dart:async';
import 'package:remote_flutter_app/models/thermostat.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Thermostat {
  final ThermostatSettingsModel _currentSettings = ThermostatSettingsModel();

  late Timer updateForecastTimer =
      Timer(const Duration(seconds: 15), () => retriveLatestSettings());

  void refreshThermostat() {
    Timer.run(() => retriveLatestSettings());
  }

  ThermostatSettingsModel get currentSettings {
    return _currentSettings;
  }

  String get thermostatApiUrl {
    var localHostname = "remote-livingroom.local" ?? Platform.localHostname;
    var thermostatName = "hvac-livingroom";

    if (localHostname.startsWith("remote-")) {
      thermostatName = localHostname.replaceFirst(RegExp("^remote-"), "");
    }

    if (thermostatName.endsWith(".local")) {
      thermostatName = thermostatName.replaceFirst(RegExp(".local\$"), "");
    }

    return "http://hvac-$thermostatName.local/climate/hvac-$thermostatName/";
  }

  Future<void> retriveLatestSettings() async {
    var res = await http.get(Uri.parse(thermostatApiUrl));
    dynamic resp = json.decode(res.body);

    var targetTemp =
        ((double.parse(resp["target_temperature"]) * 1.8) + 32).round();
    var currentTemp =
        ((double.parse(resp["current_temperature"]) * 1.8) + 32).round();

    ThermostatMode mode = ThermostatMode.off;
    switch (resp["mode"]) {
      case "OFF":
        mode = ThermostatMode.off;
        break;
      case "HEAT_COOL":
        mode = ThermostatMode.auto;
        break;
      case "COOL":
        mode = ThermostatMode.cooling;
        break;
      case "HEAT":
        mode = ThermostatMode.heating;
        break;
      case "FAN ONLY":
        mode = ThermostatMode.fan;
        break;
    }

    FanSpeed fanSpeed = FanSpeed.auto;
    switch (resp["fan_mode"]) {
      case "AUTO":
        fanSpeed = FanSpeed.auto;
        break;
      case "LOW":
        fanSpeed = FanSpeed.one;
        break;
      case "MEDIUM":
        fanSpeed = FanSpeed.two;
        break;
      case "MIDDLE":
        fanSpeed = FanSpeed.three;
        break;
      case "HIGH":
        fanSpeed = FanSpeed.four;
        break;
      case "DIFFUSE":
        fanSpeed = FanSpeed.quiet;
        break;
    }

    currentSettings.receiveValuesFromUnit(
        targetTemp, currentTemp, mode, fanSpeed);
  }
}
