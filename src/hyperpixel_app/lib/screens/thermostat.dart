import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_flutter_app/models/thermostat.dart';

class ThermostatWidget extends StatelessWidget {
  const ThermostatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var thermostat = context.watch<ThermostatSettingsModel>();
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          const ListTile(title: Text('Inside')),
          ListTile(
              leading: Icon(Icons.waves, color: colorFromMode(thermostat.mode)),
              title: Text('Currently: ${thermostat.currentTemp}°F')),
          ListTile(
              title: Text(
                  'Set to: ${thermostat.setTemp}°F ${stringFromMode(thermostat.mode)}'))
        ]));
  }

  dynamic colorFromMode(ThermostatMode mode) {
    if (mode == ThermostatMode.heating) {
      return const Color.fromRGBO(255, 0, 0, 1);
    } else if (mode == ThermostatMode.cooling) {
      return const Color.fromRGBO(0, 0, 255, 1);
    }

    return null;
  }

  String stringFromMode(ThermostatMode mode) {
    if (mode == ThermostatMode.heating) {
      return "Heating";
    }

    if (mode == ThermostatMode.cooling) {
      return "Cooling";
    }

    if (mode == ThermostatMode.fan) {
      return "Fan only";
    }

    if (mode == ThermostatMode.off) {
      return "Off";
    }

    return mode.toString();
  }
}