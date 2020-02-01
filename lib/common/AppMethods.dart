import 'package:flutter/material.dart';

class AppMethods {
//region Open Screen
  static void openScreen(BuildContext buildContext, Widget screenWidgetName,
      bool isPushReplacement) {
    print("" + screenWidgetName.toString());
    if (isPushReplacement) {
      Navigator.pushReplacement(
        buildContext,
        MaterialPageRoute(builder: (context) => screenWidgetName),
      );
    } else {
      Navigator.push(
        buildContext,
        MaterialPageRoute(builder: (context) => screenWidgetName),
      );
    }
  }
//endregion
}
