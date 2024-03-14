import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class AppUtil {
  static Future<bool> checkNetwork() async {
    if (Platform.isAndroid) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    } else {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
        }
        return true;
      } on SocketException catch (_) {
        print('not connected');
        return false;
      }
    }
  }
}
