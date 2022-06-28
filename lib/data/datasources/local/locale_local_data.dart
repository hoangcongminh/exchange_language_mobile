import 'dart:ui';

import 'package:exchange_language_mobile/common/constants/storage_key.dart';
import 'package:hive/hive.dart';

class LocaleLocal {
  var box = Hive.box(StorageKey.BOX_LOCALE);

  void setLocale(Locale locale) {
    box.put(StorageKey.LOCALE, locale.toString());
  }

  Locale? getLocale() {
    final locale = box.get(StorageKey.LOCALE);
    if (locale == null) {
      return null;
    }
    return Locale(locale);
  }
}
