import 'package:exchange_language_mobile/data/datasources/local/base_local_data.dart';
import 'package:logger/logger.dart';

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
