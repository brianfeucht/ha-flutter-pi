import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_flutter_app/models/thermostat.dart';

class ThermostatWidget extends StatelessWidget {
  const ThermostatWidget({super.key});

  static const double setTempSize = 150;
  static const double setModeSize = 40;

  @override
  Widget build(BuildContext context) {
    var thermostat = context.watch<ThermostatSettingsModel>();
    return SizedBox(
      width: 716,
      height: 532,
      child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              const SizedBox(height: 25),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Icon(iconFromMode(thermostat.mode),
                            color: colorFromMode(thermostat.mode), size: 125),
                        Text(stringFromMode(thermostat.mode)),
                        const SizedBox(height: 50),
                        const Text("Fan"),
                        Text(textForFanSpeed(thermostat.fanSpeed)),
                      ])),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Text(
                          '${thermostat.setTemp}',
                          textScaleFactor: 10,
                          textAlign: TextAlign.center,
                        ),
                        Text('Currently: ${thermostat.currentTemp}°F')
                      ])),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        child:
                            const Icon(Icons.arrow_upward, size: setTempSize),
                        onPressed: () =>
                            thermostat.setNewTemp(thermostat.setTemp + 1),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        child:
                            const Icon(Icons.arrow_downward, size: setTempSize),
                        onPressed: () =>
                            thermostat.setNewTemp(thermostat.setTemp - 1),
                      )
                    ],
                  )),
                ],
              )),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      child: Row(children: const [
                        Icon(Icons.power, size: 50),
                        Text(" Mode")
                      ]),
                      onPressed: () => switchMode(thermostat)),
                  const SizedBox(width: 25),
                  OutlinedButton(
                      child: Row(children: const [
                        Icon(Icons.wind_power, size: 50),
                        Text(" Fan")
                      ]),
                      onPressed: () => switchFan(thermostat)),
                ],
              ),
              const SizedBox(height: 25),
            ],
          )),
    );
  }

  Color? colorFromMode(ThermostatMode mode) {
    switch (mode) {
      case ThermostatMode.heating:
        return const Color.fromRGBO(255, 0, 0, 1);
      case ThermostatMode.cooling:
        return const Color.fromRGBO(0, 0, 255, 1);
      case ThermostatMode.off:
        return const Color.fromRGBO(85, 85, 85, 1);
      case ThermostatMode.fan:
        return const Color.fromRGBO(0, 0, 0, 1);
      default:
        return const Color.fromRGBO(85, 85, 85, 1);
    }
  }

  String stringFromMode(ThermostatMode mode) {
    switch (mode) {
      case ThermostatMode.off:
        return "Off";
      case ThermostatMode.heating:
        return "Heating";
      case ThermostatMode.cooling:
        return "Cooling";
      case ThermostatMode.fan:
        return "Fan only";
      case ThermostatMode.auto:
        return "Auto";
    }
  }

  IconData iconFromMode(ThermostatMode mode) {
    switch (mode) {
      case ThermostatMode.off:
        return Icons.power_settings_new;
      case ThermostatMode.heating:
        return Icons.waves;
      case ThermostatMode.cooling:
        return Icons.ac_unit;
      case ThermostatMode.fan:
        return Icons.air;
      case ThermostatMode.auto:
        return Icons.auto_awesome;
    }
  }

  String textForFanSpeed(FanSpeed fanSpeed) {
    switch (fanSpeed) {
      case FanSpeed.one:
        return "Low";
      case FanSpeed.two:
        return "Two";
      case FanSpeed.three:
        return "Three";
      case FanSpeed.four:
        return "High";
      case FanSpeed.quiet:
        return "Quiet";
      case FanSpeed.auto:
        return "Auto";
    }
  }

  switchFan(ThermostatSettingsModel thermostat) {
    FanSpeed fanSpeed = thermostat.fanSpeed;
    final nextIndex = (fanSpeed.index + 1) % FanSpeed.values.length;
    thermostat.setFanSpeed(FanSpeed.values[nextIndex]);
  }

  switchMode(ThermostatSettingsModel thermostat) {
    ThermostatMode mode = thermostat.mode;
    final nextIndex = (mode.index + 1) % ThermostatMode.values.length;
    thermostat.setNewMode(ThermostatMode.values[nextIndex]);
  }
}
