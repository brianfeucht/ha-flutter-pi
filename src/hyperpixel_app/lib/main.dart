// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:remote_flutter_app/models/current_weather.dart';
import 'screens/current_weather.dart';
import 'tempest.dart';
import 'package:provider/provider.dart';

double screenPixels = 720;
Tempest tempest = Tempest();

void main() {
  tempest.startListening();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => tempest.currentWeather),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
                width: screenPixels,
                height: screenPixels,
                color: Colors.amber[600],
                child: Consumer<CurrentWeatherModel>(
                    builder: (context, weather, c) =>
                        CurrentWeatherWidget()))));
  }
}
