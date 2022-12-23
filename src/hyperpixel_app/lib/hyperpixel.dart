import 'package:async/async.dart';
import 'package:remote_flutter_app/models/screen_dimmer.dart';
import 'dart:io';

class HyperPixel {
  static const int dimmerPin = 19;

  // as singleton to maintain the connexion during the app life and be accessible everywhere
  static final HyperPixel _instance = HyperPixel._internal();

  final ScreenDimmerModel _dimmerState = ScreenDimmerModel(
      onDimUpdate: (model) => _instance.setScreenBrightness(model.dmw));

  final RestartableTimer idleTimer = RestartableTimer(
      const Duration(seconds: 30), () => {_instance.setScreenBrightness(0)});

  factory HyperPixel() {
    return _instance;
  }

  HyperPixel._internal();

  ScreenDimmerModel get dimmerState {
    return _dimmerState;
  }

  Future<void> setScreenBrightness(int value) async {
    try {
      await Process.run("pwm", ["19", "1000000", value.toString()]);
    } catch (e) {
      stderr.writeln("pwm call failed $e");
    }
  }

  void resetTimeout() {
    setScreenBrightness(_dimmerState.dmw);
    idleTimer.reset();
  }
}
