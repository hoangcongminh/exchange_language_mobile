part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class SelectLanguageEvent extends FilterEvent {}

class SelectLanguageDoneEvent extends FilterEvent {
  final List<Language> languages;

  const SelectLanguageDoneEvent({required this.languages});

  @override
  List<Object> get props => [languages];
}
