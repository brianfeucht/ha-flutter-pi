// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'tempest.dart';
import 'package:provider/provider.dart';

int screenPixels = 720;
Tempest tempest = Tempest();

void main() {
  tempest.startListening();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: ChangeNotifierProvider(
      create: (context) => tempest,
      builder: (context, child) => Center(
          child: Consumer<Tempest>(
              builder: (context, t, c) => Text('Current: ${t.temprature} C'))),
    )));
  }
}
