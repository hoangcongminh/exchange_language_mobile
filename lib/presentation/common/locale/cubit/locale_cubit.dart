import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const SelectedLocale(Locale('vi')));
  String language = 'Vietnamese';

  void toEnglish() {
    language = 'English';
    emit(const SelectedLocale(Locale('en')));
  }

  void toVietnamese() {
    language = 'Vietnamese';
    emit(const SelectedLocale(Locale('vi')));
  }
}
