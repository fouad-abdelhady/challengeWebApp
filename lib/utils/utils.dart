import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class Utils {
  static void screenPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  /*void showProgressDialog({@required BuildContext? buildContext}) {
    showDialog(
      context: buildContext!,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const SpinKitDoubleBounce(
                color: Color(0xff030504),
                size: 40,
              ),
            ),
          ),
        );
      },
    );
  }*/

  void hideProgressDialog({@required BuildContext? buildContext}) {
    Navigator.of(buildContext!, rootNavigator: true).pop();
  }

  String getDeviceType() {
    if (Platform.isAndroid) {
      return 'Android';
    } else {
      return 'iOS';
    }
  }

  bool emailValidator(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(email)) {
      return true;
    }

    return false;
  }

  bool phoneValidator(String contact) {
    String p = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }

    return false;
  }

  bool passwordValidator(String contact) {
    debugPrint("<<<< ------- passwordValidator ------- >>>>");
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }

    return false;
  }

  bool isValidationEmpty(String? val) {
    if (val == null ||
        val.isEmpty ||
        val == "null" ||
        val == "" ||
        val == "NULL") {
      return true;
    } else {
      return false;
    }
  }

  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  void alertDialog(BuildContext context, String? title) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "25 Oct",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          content: Text(
            title!,
            softWrap: true,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        );
      },
    );
  }

  Future<bool> isNetworkAvailable() async {
    ConnectivityResult _result;
    final Connectivity _connectivity = Connectivity();
    try {
      _result = await _connectivity.checkConnectivity();
      debugPrint(_result.toString());
      switch (_result) {
        case ConnectivityResult.wifi:
          return true;
        case ConnectivityResult.mobile:
          return true;
        default:
          return false;
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String strTime = '';
    if (hoursStr == '00' || hoursStr == '0') {
      strTime = minutesStr.toString() + ':' + secondsStr.toString();
    } else {
      strTime = hoursStr.toString() +
          ':' +
          minutesStr.toString() +
          ':' +
          secondsStr.toString();
    }
    return strTime;
  }

  /*void showToast(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      backgroundColor: Colors.black,
    );
  }*/

  String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
