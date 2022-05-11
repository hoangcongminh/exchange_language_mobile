part of 'authenticate_bloc.dart';

abstract class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticateEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });
}

class RegisterEvent extends AuthenticateEvent {
  final String email;
  final String password;
  final String fullName;
  final File avatar;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.avatar,
  });
}

class ResetPasswordEvent extends AuthenticateEvent {
  final String email;
  final String password;

  const ResetPasswordEvent({
    required this.email,
    required this.password,
  });
}

class RefreshTokenEvent extends AuthenticateEvent {}

class LogoutEvent extends AuthenticateEvent {}
