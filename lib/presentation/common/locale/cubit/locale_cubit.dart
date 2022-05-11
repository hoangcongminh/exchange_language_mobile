import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const SelectedLocale(Locale('vi')));

  void toEnglish() => emit(const SelectedLocale(Locale('en')));

  void toVietnamese() => emit(const SelectedLocale(Locale('vi')));
}
