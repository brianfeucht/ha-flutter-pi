import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/screen_dimmer.dart';

class ScreenDimmerWidget extends StatelessWidget {
  const ScreenDimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var screenDimmer = context.watch<ScreenDimmerModel>();

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
              })
        ]));
  }
}
