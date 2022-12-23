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
                        Text(stringFromMode(thermostat.mode))
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
                      onPressed: () =>
                          thermostat.setNewMode(ThermostatMode.heating),
                      child: Icon(
                        iconFromMode(ThermostatMode.heating),
                        color: colorFromMode(ThermostatMode.heating),
                        size: setModeSize,
                      )),
                  const SizedBox(width: 20),
                  OutlinedButton(
                      onPressed: () =>
                          thermostat.setNewMode(ThermostatMode.cooling),
                      child: Icon(
                        iconFromMode(ThermostatMode.cooling),
                        color: colorFromMode(ThermostatMode.cooling),
                        size: setModeSize,
                      )),
                  const SizedBox(width: 20),
                  OutlinedButton(
                      onPressed: () =>
                          thermostat.setNewMode(ThermostatMode.fan),
                      child: Icon(
                        iconFromMode(ThermostatMode.fan),
                        color: colorFromMode(ThermostatMode.fan),
                        size: setModeSize,
                      )),
                  const SizedBox(width: 20),
                  OutlinedButton(
                      onPressed: () =>
                          thermostat.setNewMode(ThermostatMode.off),
                      child: Icon(
                        iconFromMode(ThermostatMode.off),
                        color: colorFromMode(ThermostatMode.off),
                        size: setModeSize,
                      )),
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
    }
  }
}
