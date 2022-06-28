import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasources/local/locale_local_data.dart';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(getLocale());

  void toEnglish() {
    LocaleLocal().setLocale(const Locale('en'));
    emit(const Locale('en'));
  }

  void switchLanguage() {
    if (state == const Locale('en')) {
      toVietnamese();
    } else {
      toEnglish();
    }
  }

  void toVietnamese() {
    LocaleLocal().setLocale(const Locale('vi'));
    emit(const Locale('vi'));
  }

  static Locale getLocale() {
    Locale? locale = LocaleLocal().getLocale();
    if (locale == null) {
      locale = Locale(ui.window.locale.languageCode);
      LocaleLocal().setLocale(locale);
    }
    return locale;
  }
}
