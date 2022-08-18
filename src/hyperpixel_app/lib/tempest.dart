import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Tempest extends ChangeNotifier {
  // the port used by this socket
  final int _port = 50222;
  // as singleton to maintain the connexion during the app life and be accessible everywhere
  static final Tempest _instance = Tempest._internal();

  double temp = double.nan;

  double get temprature {
    return temp;
  }

  factory Tempest() {
    return _instance;
  }

  Tempest._internal();

  void startListening() {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, _port)
        .then((RawDatagramSocket socket) {
      // listen the request from server
      socket.listen((e) {
        if (e == RawSocketEvent.read) {
          Datagram? dg = socket.receive();
          if (dg != null) {
            parseMessage(utf8.decode(dg.data));
            notifyListeners();
          }
        }
      });
    });
  }

  void parseMessage(String message) {
    Map<String, dynamic> stationObs = jsonDecode(message);

    switch (stationObs["type"]) {
      case "obs_st":
        List<dynamic> obs = stationObs["obs"];
        temp = obs[0][7];
        print("Temp is $temp C");
        break;
      case "device_status":
      case "hub_status":
      case "rapid_wind":
        break;
      default:
        print(message);
    }
  }
}
