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

class Loading extends AuthenticateState {}

class VerificationSuccess extends AuthenticateState {}

class VerificationFail extends AuthenticateState {
  final String error;
  const VerificationFail({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
