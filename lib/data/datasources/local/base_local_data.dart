import 'package:exchange_language_mobile/common/constants/storage_key.dart';
import 'package:exchange_language_mobile/common/helpers/path_helper.dart';
import 'package:hive/hive.dart';

class BaseLocalData {
  static Future<void> initialBox() async {
    var path = await PathHelper.appDir;
    Hive.init(path.path);
    await Hive.openBox(StorageKey.BOX_USER);
  }
}
