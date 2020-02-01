import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppMethods {

//region  openScreen
// custom function to open new Screen
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

//region Loading
  static bool isLoading = false;

  static var loading = SpinKitDualRing(
    color: Colors.purple,
    size: 50.0,
  );
//endregion Loading

}
