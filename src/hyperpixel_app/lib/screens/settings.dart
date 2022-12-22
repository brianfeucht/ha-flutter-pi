import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/screen_dimmer.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  static const String buildVer = "**DEV-BUILD**";

  @override
  Widget build(BuildContext context) {
    var screenDimmer = context.watch<ScreenDimmerModel>();
    var windowMediaQuery = MediaQuery.of(context);

    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          const ListTile(title: Text('Screen Brightness')),
          Slider(
              value: screenDimmer.dmw.toDouble(),
              max: ScreenDimmerModel.maxDmw.toDouble(),
              min: ScreenDimmerModel.minDmw.toDouble(),
              onChanged: (value) {
                screenDimmer.setValue(value.toInt());
              }),
          Text("Pixel Ratio: ${windowMediaQuery.devicePixelRatio}"),
          Text("Window Size: ${windowMediaQuery.size}"),
          const Text("Build Hash: $buildVer"),
        ]));
  }
}
