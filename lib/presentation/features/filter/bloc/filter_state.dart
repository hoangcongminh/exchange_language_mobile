part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}

class SelectLanguageState extends FilterState {
  final List<Language> languages;

  SelectLanguageState({required this.languages});

  @override
  List<Object> get props => [languages];
}

class FilterResult extends FilterState {
  final List<User> users;
  FilterResult({required this.users});
}

class FilterFailure extends FilterState {}

class FilterLoading extends FilterState {}
