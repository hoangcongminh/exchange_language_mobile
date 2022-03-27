part of 'authenticate_bloc.dart';

abstract class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationCheck extends AuthenticateEvent {}

class LoginEvent extends AuthenticateEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });
}

class SignUpEvent extends AuthenticateEvent {
  final String email;

  const SignUpEvent({
    required this.email,
  });
}

class LogoutEvent extends AuthenticateEvent {}

class VerifyEvent extends AuthenticateEvent {
  final String verificationCode;

  const VerifyEvent({
    required this.verificationCode,
  });
}
