import 'package:hive/hive.dart';

import '../../../common/constants/storage_key.dart';
import '../../../domain/entities/user.dart';
import '../../models/user_model.dart';

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
    final user = box.get(StorageKey.USER);
    if (user == null) {
      return null;
    }
    return UserModel.fromJson(user).toEntity();
  }

  void setUser(UserModel user) {
    box.put(StorageKey.USER, user.toJson());
  }

  void clearUser() {
    box.delete(StorageKey.USER);
  }
}
