part of 'authenticate_bloc.dart';

abstract class AuthenticateState extends Equatable {
  const AuthenticateState();

  @override
  List<Object> get props => [];
}

class AuthenticateInitial extends AuthenticateState {}

class AuthenticationSuccess extends AuthenticateState {}

class AuthenticationFail extends AuthenticateState {
  final String error;
  const AuthenticationFail({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class Authenticating extends AuthenticateState {}
