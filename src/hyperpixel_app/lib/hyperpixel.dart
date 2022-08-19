import 'package:remote_flutter_app/models/screen_dimmer.dart';

class HyperPixel {
  static const int dimmerPin = 19;

  // as singleton to maintain the connexion during the app life and be accessible everywhere
  static final HyperPixel _instance = HyperPixel._internal();

  final ScreenDimmerModel _dimmerState = ScreenDimmerModel();

  factory HyperPixel() {
    return _instance;
  }

  HyperPixel._internal();

  ScreenDimmerModel get dimmerState {
    return _dimmerState;
  }

  Future initialize() async {}
}
