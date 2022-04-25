part of 'application_bloc.dart';

abstract class ApplicationState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialApplicationState extends ApplicationState {}

class ApplicationStart extends ApplicationState {}

class ApplicationAuthorized extends ApplicationState {}

class ApplicationUnauthorized extends ApplicationState {}
