part of 'application_bloc.dart';

abstract class ApplicationEvent {
  const ApplicationEvent();
}

class OnSetupApplication extends ApplicationEvent {}

class OnLoggedIn extends ApplicationEvent {}

class OnLoggedOut extends ApplicationEvent {}
