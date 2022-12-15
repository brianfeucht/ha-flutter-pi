import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_flutter_app/models/thermostat.dart';

class ThermostatWidget extends StatelessWidget {
  const ThermostatWidget({super.key});

  static const double setTempSize = 100;
  static const double setModeSize = 40;

  @override
  Widget build(BuildContext context) {
    var thermostat = context.watch<ThermostatSettingsModel>();
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          Row(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(iconFromMode(thermostat.mode),
                        color: colorFromMode(thermostat.mode),
                        size: setTempSize * 2),
                    Text('Mode: ${stringFromMode(thermostat.mode)}'),
                    Text('Currently: ${thermostat.currentTemp}°F'),
                  ]),
              Expanded(
                child: Text(
                  '${thermostat.setTemp}',
                  textScaleFactor: 8,
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  OutlinedButton(
                    child: const Icon(Icons.arrow_upward, size: setTempSize),
                    onPressed: () =>
                        thermostat.setNewTemp(thermostat.setTemp + 1),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    child: const Icon(Icons.arrow_downward, size: setTempSize),
                    onPressed: () =>
                        thermostat.setNewTemp(thermostat.setTemp - 1),
                  )
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  OutlinedButton(
                      onPressed: () =>
                          thermostat.setNewMode(ThermostatMode.heating),
                      child: Icon(
                        iconFromMode(ThermostatMode.heating),
                        color: colorFromMode(ThermostatMode.heating),
                        size: setModeSize,
                      )),
                  const SizedBox(height: 10),
                  OutlinedButton(
                      onPressed: () =>
                          thermostat.setNewMode(ThermostatMode.cooling),
                      child: Icon(
                        iconFromMode(ThermostatMode.cooling),
                        color: colorFromMode(ThermostatMode.cooling),
                        size: setModeSize,
                      )),
                  const SizedBox(height: 10),
                  OutlinedButton(
                      onPressed: () =>
                          thermostat.setNewMode(ThermostatMode.fan),
                      child: Icon(
                        iconFromMode(ThermostatMode.fan),
                        color: colorFromMode(ThermostatMode.fan),
                        size: setModeSize,
                      )),
                  const SizedBox(height: 10),
                  OutlinedButton(
                      onPressed: () =>
                          thermostat.setNewMode(ThermostatMode.off),
                      child: Icon(
                        iconFromMode(ThermostatMode.off),
                        color: colorFromMode(ThermostatMode.off),
                        size: setModeSize,
                      )),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
        ]));
  }

  Color? colorFromMode(ThermostatMode mode) {
    switch (mode) {
      case ThermostatMode.heating:
        return const Color.fromRGBO(255, 0, 0, 1);
      case ThermostatMode.cooling:
        return const Color.fromRGBO(0, 0, 255, 1);
      default:
        return null;
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
        return Icons.disabled_by_default_rounded;
      case ThermostatMode.heating:
        return Icons.waves;
      case ThermostatMode.cooling:
        return Icons.ac_unit;
      case ThermostatMode.fan:
        return Icons.air;
    }
  }
}
