import 'package:flutter/foundation.dart';
import 'dart:io';

class ScreenDimmerModel extends ChangeNotifier {
  static const int offDmw = 0;
  static const int minDmw = 130667;
  static const int maxDmw = 400000;

  int _currentDmw = minDmw;

  int get dmw {
    return _currentDmw;
  }

  void setValue(int value) async {
    _currentDmw = value;

    await Process.run("pwm", ["19", "1000000", value.toString()]);

    notifyListeners();
  }
}
