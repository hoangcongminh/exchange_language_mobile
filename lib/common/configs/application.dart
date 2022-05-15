import 'package:logger/logger.dart';

import '../../data/datasources/local/base_local_data.dart';

class Application {
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();

  Future<void> initialApplication() async {
    try {
      await BaseLocalData.initialBox();
    } catch (error) {
      Logger().e(error.toString());
    }
  }
}
