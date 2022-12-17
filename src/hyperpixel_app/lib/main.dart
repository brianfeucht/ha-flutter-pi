// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remote_flutter_app/hyperpixel.dart';
import 'package:remote_flutter_app/models/current_weather.dart';
import 'package:remote_flutter_app/models/thermostat.dart';
import 'package:remote_flutter_app/screens/thermostat.dart';
import 'package:remote_flutter_app/screens/weather_forecast.dart';
import 'package:remote_flutter_app/thermostat.dart';
import 'package:remote_flutter_app/weather_forecast.dart';
import 'package:window_manager/window_manager.dart';
import 'models/weather_forecast.dart';
import 'screens/current_weather.dart';
import 'package:remote_flutter_app/models/screen_dimmer.dart';
import 'package:remote_flutter_app/screens/screen_dimmer.dart';
import 'tempest.dart';
import 'package:provider/provider.dart';

double screenPixels = 720;
Tempest tempest = Tempest();
HyperPixel hyperPixelScreen = HyperPixel();
Thermostat thermostat = Thermostat();
WeatherForecast weatherForecast = WeatherForecast();

void main() async {
  tempest.startListening();
  weatherForecast.refreshForecast();

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setSize(const Size(720, 720));
  }

  runApp(MultiProvider(providers: [
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
                    Column(children: [
                      Consumer<ThermostatSettingsModel>(
                          builder: (context, thermostatSettings, child) =>
                              const ThermostatWidget()),
                      Row(
                        children: [
                          Consumer<CurrentWeatherModel>(
                              builder: (context, weather, c) =>
                                  const CurrentWeatherWidget()),
                          Consumer<WeatherForecastModel>(
                              builder: (context, weather, c) =>
                                  const WeatherForecastWidget())
                        ],
                      )
                    ]),
                    Consumer<ScreenDimmerModel>(
                        builder: (context, weather, c) =>
                            const ScreenDimmerWidget()),
                  ]),
                ))));
  }
}
