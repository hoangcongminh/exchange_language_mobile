import 'package:hive/hive.dart';

import '../../../common/constants/storage_key.dart';
import '../../../domain/entities/user.dart';

class UserLocal {
  var box = Hive.box(StorageKey.BOX_USER);

  String getAccessToken() {
    return box.get(StorageKey.TOKEN) ?? '';
  }

  void setAccessToken(String accessToken) {
    box.put(StorageKey.TOKEN, accessToken);
  }

  void clearAccessToken() {
    box.delete(StorageKey.TOKEN);
  }

  User? getUser() {
    var _user = box.get(StorageKey.USER);
    if (_user == null) {
      return null;
    }
    return _user;
  }

  void setUser(User user) {
    box.put(StorageKey.USER, user);
  }
}
