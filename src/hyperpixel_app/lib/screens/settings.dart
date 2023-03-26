import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_flutter_app/models/log.dart';

import '../models/screen_dimmer.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var screenDimmer = context.watch<ScreenDimmerModel>();
    var appLog = context.watch<AppLog>();

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
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, //.horizontal
                  child: Text(appLog.logMessages.join("\n")))),
        ]));
  }
}
