import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../data/failure.dart';
import '../../../../domain/entities/media.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../domain/repository/media_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../common/application/application_bloc.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  AuthenticateBloc(this._authRepository, this._mediaRepository)
      : super(AuthenticateInitial()) {
    on<RegisterEvent>(
      (event, emit) async {
        emit(Authenticating());
        if (event.avatar == null) {
          emit(const AuthenticationFail(error: 'Invalid avatar'));
        } else {
          Either<Failure, Media> imageResult =
              await _mediaRepository.uploadImage(event.avatar!);
          await imageResult.fold(
            (failure) {
              emit(AuthenticationFail(error: failure.message));
            },
            (image) async {
              Either<Failure, String> result = await _authRepository.register(
                event.email,
                event.password,
                event.fullName,
                image.id,
              );
              result.fold(
                (failure) {
                  emit(AuthenticationFail(error: failure.message));
                },
                (token) {
                  emit(AuthenticationSuccess());
                  AppBloc.applicationBloc.add(OnLoggedIn());
                },
              );
            },
          );
        }
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

    on<ResetPasswordEvent>((event, emit) async {
      emit(Authenticating());
      Either<Failure, String> result =
          await _authRepository.resetPassword(event.email, event.password);
      result.fold((failue) {
        emit(AuthenticationFail(error: failue.message));
      }, (success) {
        _navigator.pushNamedAndRemoveUntil(RouteConstants.login);
        emit(AuthenticateInitial());
      });
    });

    on<RefreshTokenEvent>(
      (event, emit) async {
        Either<Failure, User> result = await _authRepository.refreshToken();
        await result.fold((failure) async {
          debugPrint(failure.message);
          await _authRepository.logout();
          AppBloc.applicationBloc.add(OnLoggedOut());
          emit(AuthenticateInitial());
        }, (user) {
          return;
        });
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
  }

  final AuthRepository _authRepository;
  final MediaRepository _mediaRepository;
  final AppNavigator _navigator = AppNavigator();
}
