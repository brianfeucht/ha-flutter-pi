import 'package:circular_buffer/circular_buffer.dart';
import 'package:flutter/foundation.dart';

class AppLog extends ChangeNotifier {
  CircularBuffer<String> logBuffer = CircularBuffer<String>(500);

  void addLog(String logMessage) {
    logBuffer.add(logMessage);
    notifyListeners();
  }

  Iterable<String> get logMessages {
    return List.unmodifiable(logBuffer);
  }
}
