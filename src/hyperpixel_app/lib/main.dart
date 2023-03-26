// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remote_flutter_app/hyperpixel.dart';
import 'package:remote_flutter_app/models/current_weather.dart';
import 'package:remote_flutter_app/models/log.dart';
import 'package:remote_flutter_app/models/thermostat.dart';
import 'package:remote_flutter_app/screens/thermostat.dart';
import 'package:remote_flutter_app/screens/weather_forecast.dart';
import 'package:remote_flutter_app/thermostat.dart';
import 'package:remote_flutter_app/weather_forecast.dart';
import 'package:window_manager/window_manager.dart';
import 'models/weather_forecast.dart';
import 'screens/current_weather.dart';
import 'package:remote_flutter_app/models/screen_dimmer.dart';
import 'package:remote_flutter_app/screens/settings.dart';
import 'tempest.dart';
import 'package:provider/provider.dart';

const String buildVer = "**DEV-BUILD**";

double screenPixels = 720;
AppLog appLog = AppLog();

Tempest tempest = Tempest();
HyperPixel hyperPixelScreen = HyperPixel(appLog);
Thermostat thermostat = Thermostat(appLog);
WeatherForecast weatherForecast = WeatherForecast(appLog);

void main() async {
  hyperPixelScreen.resetTimeout();
  tempest.startListening();
  weatherForecast.refreshForecast();
  thermostat.refreshThermostat();

  appLog.addLog("Build Hash: $buildVer");

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    await WindowManager.instance.setSize(const Size(737, 760));
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => appLog),
    ChangeNotifierProvider(create: (context) => tempest.currentWeather),
    ChangeNotifierProvider(create: (context) => hyperPixelScreen.dimmerState),
    ChangeNotifierProvider(create: (context) => thermostat.currentSettings),
    ChangeNotifierProvider(
        create: (context) => weatherForecast.currentForecast),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Droid Sans Mono for Powerline'),
        home: GestureDetector(
            onTap: () => hyperPixelScreen.resetTimeout(),
            onTapCancel: () => hyperPixelScreen.resetTimeout(),
            child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                      bottom: const TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.thermostat)),
                          Tab(icon: Icon(Icons.settings)),
                        ],
                      ),
                      toolbarHeight: 0),
                  body: TabBarView(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Consumer<ThermostatSettingsModel>(
                              builder: (context, m, child) =>
                                  const ThermostatWidget()),
                          Row(
                            children: [
                              Consumer<CurrentWeatherModel>(
                                  builder: (context, m, c) =>
                                      const CurrentWeatherWidget()),
                              Consumer<WeatherForecastModel>(
                                  builder: (context, m, c) =>
                                      const WeatherForecastWidget())
                            ],
                          )
                        ]),
                    Consumer2<ScreenDimmerModel, AppLog>(
                        builder: (context, dim, log, w) =>
                            const SettingsWidget()),
                  ]),
                ))));
  }
}
