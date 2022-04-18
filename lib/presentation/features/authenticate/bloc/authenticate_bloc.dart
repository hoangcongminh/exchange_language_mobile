import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:exchange_language_mobile/data/failure.dart';
import 'package:exchange_language_mobile/domain/repository/auth_repository.dart';
import 'package:exchange_language_mobile/presentation/common-bloc/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/common-bloc/application/application_bloc.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  AuthenticateBloc(this._authRepository) : super(AuthenticateInitial()) {
    on<RegisterEvent>(
      (event, emit) async {
        Either<Failure, String> result = await _authRepository.register(
          event.email,
          event.password,
          event.fullName,
        );
        result.fold(
          (failure) {
            emit(AuthenticationFail(error: failure.message));
          },
          (token) {
            UserLocal().setAccessToken(token);
            emit(AuthenticationSuccess());
          },
        );

        emit(AuthenticationSuccess());
      },
    );

    on<LoginEvent>(
      (event, emit) async {
        emit(Authenticating());
        Either<Failure, String> result =
            await _authRepository.login(event.email, event.password);
        result.fold(
          (failue) {
            emit(AuthenticationFail(error: failue.message));
          },
          (token) async {
            emit(AuthenticationSuccess());
            AppBloc.applicationBloc.add(OnLoggedIn());
          },
        );
      },
    );

    on<LogoutEvent>(
      (event, emit) async {
        emit(Authenticating());
        await _authRepository.logout();
        AppBloc.applicationBloc.add(OnLoggedOut());
        emit(AuthenticateInitial());
      },
    );

    on<SendOTPEvent>((event, emit) async {
      emit(Authenticating());
      Either<Failure, void> result = await _authRepository.sendOTP(event.email);
      result.fold(
        (failue) {
          emit(AuthenticationFail(error: failue.message));
        },
        (data) {
          emit(AuthenticationSuccess());
          _navigator.push(RouteConstants.verification,
              arguments: {'email': event.email});
        },
      );
    });

    on<VerifyOTPEvent>((event, emit) async {
      Either<Failure, void> result =
          await _authRepository.verifyOTP(event.email, event.otp);
      result.fold(
        (failue) {
          emit(VerificationFail(error: failue.message));
        },
        (data) {
          emit(VerificationSuccess());
          _navigator.push(RouteConstants.register);
        },
      );
    });
  }

  final AuthRepository _authRepository;
  final AppNavigator _navigator = AppNavigator();
}
