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

  void setScreenBrightness(int value) {
    Process.run("pwm", ["19", "1000000", value.toString()]).ignore();
    idleTimer.reset();
  }

  void resetTimeout() {
    if (!idleTimer.isActive) {
      setScreenBrightness(_dimmerState.dmw);
    }

    idleTimer.reset();
  }
}
