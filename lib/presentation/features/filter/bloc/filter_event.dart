part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class SelectLanguageEvent extends FilterEvent {}

class SearchUserEvent extends FilterEvent {
  final int type;
  final List<Language> speakingLanguages;
  final List<Language> learningLanguage;

  const SearchUserEvent(
      this.type, this.speakingLanguages, this.learningLanguage);
}
