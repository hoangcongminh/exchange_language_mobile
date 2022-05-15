import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../data/failure.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../routes/app_pages.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc(this._authRepository) : super(VerificationInitial()) {
    on<SendOTPEvent>((event, emit) async {
      emit(VerificationLoading());
      isForgotPassword = event.isForgotPassword;
      Either<Failure, void> result =
          await _authRepository.sendOTP(event.email, isForgotPassword);
      result.fold(
        (failue) {
          emit(SendOtpFail(error: failue.message));
        },
        (data) {
          emit(SendOtpSuccess());
          _navigator.push(RouteConstants.verification,
              arguments: {'email': event.email});
        },
      );
    });

    on<VerifyOTPEvent>((event, emit) async {
      emit(VerificationLoading());
      Either<Failure, void> result =
          await _authRepository.verifyOTP(event.email, event.otp);
      result.fold(
        (failue) {
          emit(VerificationFail(error: failue.message));
        },
        (data) {
          emit(VerificationSuccess());
          if (isForgotPassword) {
            _navigator.pushNamedAndRemoveUntil(RouteConstants.forgotPassword,
                arguments: {'email': event.email});
          } else {
            _navigator.pushNamedAndRemoveUntil(RouteConstants.register,
                arguments: {'email': event.email});
          }
        },
      );
    });
  }

  bool isForgotPassword = false;
  final AuthRepository _authRepository;
  final AppNavigator _navigator = AppNavigator();
}