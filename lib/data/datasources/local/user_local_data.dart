import 'package:exchange_language_mobile/common/constants/storage_key.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';
import 'package:hive/hive.dart';

class UserLocal {
  var box = Hive.box(StorageKey.BOX_USER);

  String getAccessToken() {
    return box.get(StorageKey.TOKEN) ?? '';
  }

  void setAccessToken(String accessToken) {
    box.put(StorageKey.TOKEN, accessToken);
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
