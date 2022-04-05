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

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });
}

class SendOTPEvent extends AuthenticateEvent {
  final String email;

  const SendOTPEvent({
    required this.email,
  });
}

class VerifyOTPEvent extends AuthenticateEvent {
  final String email;
  final String otp;

  const VerifyOTPEvent({
    required this.email,
    required this.otp,
  });
}

class LogoutEvent extends AuthenticateEvent {}
