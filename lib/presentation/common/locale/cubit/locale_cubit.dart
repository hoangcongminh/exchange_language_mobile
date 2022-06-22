import 'dart:ui' as ui;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(SelectedLocale(Locale(ui.window.locale.languageCode)));
  String language = Locale(ui.window.locale.languageCode).toString();

  void toEnglish() {
    language = 'English';
    emit(const SelectedLocale(Locale('en')));
  }

  void toVietnamese() {
    language = 'Vietnamese';
    emit(const SelectedLocale(Locale('vi')));
  }
}
