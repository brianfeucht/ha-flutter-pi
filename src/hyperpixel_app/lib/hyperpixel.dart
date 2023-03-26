import 'package:async/async.dart';
import 'package:remote_flutter_app/models/log.dart';
import 'package:remote_flutter_app/models/screen_dimmer.dart';
import 'dart:io';

class HyperPixel {
  static const int dimmerPin = 19;
  static const int dimBrightness = 180000;
  static const int offBrightness = 0;

  late ScreenDimmerModel _dimmerState;
  late RestartableTimer _idleTimer;
  final AppLog _appLog;

  HyperPixel(AppLog appLog) : _appLog = appLog {
    _idleTimer =
        RestartableTimer(const Duration(seconds: 30), () => {dimScreen()});

    _dimmerState = ScreenDimmerModel(
        onDimUpdate: (model) => setScreenBrightness(model.dmw));
  }

  ScreenDimmerModel get dimmerState {
    return _dimmerState;
  }

  Future<void> setScreenBrightness(int value) async {
    try {
      await Process.run("pwm", ["19", "1000000", value.toString()]);
    } catch (e) {
      _appLog.addLog("pwm call failed $e");
    }
  }

  void dimScreen() {
    // Turn on the screen from 7AM to 7PM otherwise turn off
    if (DateTime.now().hour > 7 && DateTime.now().hour < 19) {
      setScreenBrightness(dimBrightness);
    } else {
      setScreenBrightness(offBrightness);
    }

    _idleTimer.reset();
  }

  void resetTimeout() {
    setScreenBrightness(_dimmerState.dmw);
    _idleTimer.reset();
  }
}
