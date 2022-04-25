part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class SendOTPEvent extends VerificationEvent {
  final String email;
  final bool isForgotPassword;

  const SendOTPEvent({
    required this.email,
    required this.isForgotPassword,
  });
}

class VerifyOTPEvent extends VerificationEvent {
  final String email;
  final String otp;

  const VerifyOTPEvent({
    required this.email,
    required this.otp,
  });
}
