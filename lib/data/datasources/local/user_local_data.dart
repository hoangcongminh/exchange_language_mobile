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
    var user = box.get(StorageKey.USER);
    if (user == null) {
      return null;
    }
    return user;
  }

  void setUser(User user) {
    box.put(StorageKey.USER, user);
  }
}
