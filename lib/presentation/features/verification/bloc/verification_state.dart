part of 'verification_bloc.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}

class SendOtpSuccess extends VerificationState {}

class SendOtpFail extends VerificationState {
  final String error;
  const SendOtpFail({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class VerificationSuccess extends VerificationState {}

class VerificationFail extends VerificationState {
  final String error;
  const VerificationFail({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class VerificationLoading extends VerificationState {}
