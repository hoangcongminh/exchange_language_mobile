part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}

class SelectLanguageState extends FilterState {
  final List<Language> languages;

  const SelectLanguageState({required this.languages});

  @override
  List<Object> get props => [languages];
}

class FilterFailure extends FilterState {}
