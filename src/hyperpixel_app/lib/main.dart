// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:remote_flutter_app/hyperpixel.dart';
import 'package:remote_flutter_app/models/current_weather.dart';
import 'package:remote_flutter_app/models/thermostat.dart';
import 'package:remote_flutter_app/screens/thermostat.dart';
import 'package:remote_flutter_app/thermostat.dart';
import 'screens/current_weather.dart';
import 'package:remote_flutter_app/models/screen_dimmer.dart';
import 'package:remote_flutter_app/screens/screen_dimmer.dart';
import 'tempest.dart';
import 'package:provider/provider.dart';

double screenPixels = 720;
Tempest tempest = Tempest();
HyperPixel hyperPixelScreen = HyperPixel();
Thermostat thermostat = Thermostat();

void main() async {
  tempest.startListening();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => tempest.currentWeather),
    ChangeNotifierProvider(create: (context) => hyperPixelScreen.dimmerState),
    ChangeNotifierProvider(create: (context) => thermostat.currentSettings),
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
                      Consumer<CurrentWeatherModel>(
                          builder: (context, weather, c) =>
                              CurrentWeatherWidget()),
                      Consumer<ThermostatSettingsModel>(
                          builder: (context, thermostatSettings, child) =>
                              const ThermostatWidget()),
                    ]),
                    Consumer<ScreenDimmerModel>(
                        builder: (context, weather, c) =>
                            const ScreenDimmerWidget()),
                  ]),
                ))));
  }
}
