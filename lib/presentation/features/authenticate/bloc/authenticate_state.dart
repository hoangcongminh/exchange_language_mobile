part of 'authenticate_bloc.dart';

abstract class AuthenticateState extends Equatable {
  const AuthenticateState();

  @override
  List<Object> get props => [];
}

class AuthenticateInitial extends AuthenticateState {}

class AuthenticationSuccess extends AuthenticateState {}

class AuthenticationFail extends AuthenticateState {}

class Verifying extends AuthenticateState {}

class Authenticating extends AuthenticateState {}
