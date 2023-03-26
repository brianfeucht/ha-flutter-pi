import 'dart:async';
import 'package:http/http.dart';
import 'package:remote_flutter_app/models/log.dart';
import 'package:remote_flutter_app/models/thermostat.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mutex/mutex.dart';

class Thermostat {
  final ThermostatSettingsModel _currentSettings = ThermostatSettingsModel();
  final updateMutex = Mutex();

  late Timer updateForecastTimer =
      Timer(const Duration(seconds: 15), () => retriveLatestSettings());

  final AppLog _appLog;

  Thermostat(AppLog appLog) : _appLog = appLog {
    _currentSettings.onModelUpdate = sendNewSettings;
  }

  void refreshThermostat() {
    Timer.run(() => retriveLatestSettings());
  }

  ThermostatSettingsModel get currentSettings {
    return _currentSettings;
  }

  String get thermostatApiUrl {
    var localHostname = Platform.localHostname;
    var thermostatName = "livingroom";

    if (localHostname.startsWith("remote-")) {
      thermostatName = localHostname.replaceFirst(RegExp("^remote-"), "");
    }

    if (thermostatName.endsWith(".local")) {
      thermostatName = thermostatName.replaceFirst(RegExp(".local\$"), "");
    }

    return "http://hvac-$thermostatName.local/climate/hvac-$thermostatName/";
  }

  Future<void> retriveLatestSettings() async {
    Response res;
    try {
      res = await http.get(Uri.parse(thermostatApiUrl));
    } catch (e) {
      _appLog.addLog("Unable to get settings at $thermostatApiUrl");
      _appLog.addLog(e.toString());
      return;
    }

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
      case "FAN_ONLY":
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

  Future<void> setTargetTemp(int targetTemp) async {
    var tempC = (targetTemp - 32) / 1.8;
    await http
        .post(Uri.parse("${thermostatApiUrl}set?target_temperature=$tempC"));
  }

  Future<void> setMode(ThermostatMode mode) async {
    String urlMode = "OFF";

    switch (mode) {
      case ThermostatMode.off:
        urlMode = "OFF";
        break;
      case ThermostatMode.auto:
        urlMode = "HEAT_COOL";
        break;
      case ThermostatMode.cooling:
        urlMode = "COOL";
        break;
      case ThermostatMode.heating:
        urlMode = "HEAT";
        break;
      case ThermostatMode.fan:
        urlMode = "FAN_ONLY";
        break;
    }

    await http.post(Uri.parse("${thermostatApiUrl}set?mode=$urlMode"));
  }

  Future<void> setFanSpeed(FanSpeed fanSpeed) async {
    String urlSpeed = "AUTO";

    switch (fanSpeed) {
      case FanSpeed.auto:
        urlSpeed = "AUTO";
        break;
      case FanSpeed.quiet:
        urlSpeed = "DIFFUSE";
        break;
      case FanSpeed.one:
        urlSpeed = "LOW";
        break;
      case FanSpeed.two:
        urlSpeed = "MEDIUM";
        break;
      case FanSpeed.three:
        urlSpeed = "MIDDLE";
        break;
      case FanSpeed.four:
        urlSpeed = "HIGH";
        break;
    }

    await http.post(Uri.parse("${thermostatApiUrl}set?fan_mode=$urlSpeed"));
  }

  Future<void> sendNewSettings(ThermostatSettingsModel updatedSettings) async {
    if (updateMutex.isLocked) {
      return;
    }

    await updateMutex.protect(() async {
      try {
        // Batch multiple button pushes into a set of single update commands
        await Future.delayed(const Duration(seconds: 10));

        await setTargetTemp(_currentSettings.setTemp);
        //await setFanSpeed(_currentSettings.fanSpeed);
        await setMode(_currentSettings.mode);

        await Future.delayed(const Duration(seconds: 2));
        await retriveLatestSettings();

        _appLog.addLog("Update call succeeded");
      } catch (e) {
        _appLog.addLog("Update call failed");
        _appLog.addLog(e.toString());
      }
    });
  }
}
