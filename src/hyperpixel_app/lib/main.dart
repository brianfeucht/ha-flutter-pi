// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:remote_flutter_app/hyperpixel.dart';
import 'package:remote_flutter_app/models/current_weather.dart';
import 'screens/current_weather.dart';
import 'package:remote_flutter_app/models/screen_dimmer.dart';
import 'package:remote_flutter_app/screens/screen_dimmer.dart';
import 'tempest.dart';
import 'package:provider/provider.dart';

double screenPixels = 720;
Tempest tempest = Tempest();
HyperPixel hyperPixelScreen = HyperPixel();

void main() async {
  tempest.startListening();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => tempest.currentWeather),
    ChangeNotifierProvider(create: (context) => hyperPixelScreen.dimmerState),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: GestureDetector(
                onTap: () => hyperPixelScreen.resetTimeout(),
                onTapCancel: () => hyperPixelScreen.resetTimeout(),
                child: Container(
                  width: screenPixels,
                  height: screenPixels,
                  color: Colors.amber[600],
                  child: Column(children: [
                    Consumer<CurrentWeatherModel>(
                        builder: (context, weather, c) =>
                            CurrentWeatherWidget()),
                    Consumer<ScreenDimmerModel>(
                        builder: (context, weather, c) =>
                            const ScreenDimmerWidget()),
                  ]),
                ))));
  }
}
