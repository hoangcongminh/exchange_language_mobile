import 'package:flutter/services.dart';

class DeviceOrientationHelper {
  void setPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
