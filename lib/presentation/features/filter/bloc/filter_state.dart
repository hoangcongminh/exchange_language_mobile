part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  final List<Language> selectedLanguages;
  const FilterState({required this.selectedLanguages});

  @override
  List<Object> get props => [selectedLanguages];
}

class FilterInitial extends FilterState {
  const FilterInitial({required List<Language> selectedLanguages})
      : super(selectedLanguages: selectedLanguages);
}

class SelectLanguageState extends FilterState {
  final List<Language> languages;

  const SelectLanguageState({required this.languages})
      : super(selectedLanguages: languages);

  @override
  List<Object> get props => [languages];
}

class FilterFailure extends FilterState {
  const FilterFailure({required List<Language> selectedLanguages})
      : super(selectedLanguages: selectedLanguages);
}
