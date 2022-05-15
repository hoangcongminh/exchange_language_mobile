import 'package:hive/hive.dart';

import '../../../common/constants/storage_key.dart';
import '../../../common/helpers/path_helper.dart';

class BaseLocalData {
  static Future<void> initialBox() async {
    var path = await PathHelper.appDir;
    Hive.init(path.path);
    await Hive.openBox(StorageKey.BOX_USER);
  }
}
