import 'package:flutter/foundation.dart';

class ScreenDimmerModel extends ChangeNotifier {
  ScreenDimmerModel({this.onDimUpdate});

  static const int offDmw = 0;
  static const int minDmw = 130667;
  static const int maxDmw = 300000;

  final Function(ScreenDimmerModel)? onDimUpdate;

  int _currentDmw = minDmw;

  int get dmw {
    return _currentDmw;
  }

  void setValue(int value) {
    if (_currentDmw != value) {
      _currentDmw = value;

      notifyListeners();
      onDimUpdate!(this);
    }
  }
}
