import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
// import 'package:stacked_services/stacked_services.dart';

import 'helper/error_box_widget.dart';

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

  static showDialogbox(
    BuildContext context,
    title,
  ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ErrorBoxWidget(
            title: title.toString() ?? "Oops Something Went Wrong",
          );
        });
  }
}
