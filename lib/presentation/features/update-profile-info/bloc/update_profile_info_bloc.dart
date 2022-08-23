import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/language.dart';
import '../../../../domain/repository/media_repository.dart';
import '../../../../domain/repository/user_repository.dart';

part 'update_profile_info_event.dart';
part 'update_profile_info_state.dart';

class UpdateProfileInfoBloc
    extends Bloc<UpdateProfileInfoEvent, UpdateProfileInfoState> {
  UpdateProfileInfoBloc(this._userRepository, this._mediaRepository)
      : super(UpdateProfileInfoInitial()) {
    on<UpdateProfileInfoEvent>((event, emit) {});
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<RegisterTeacherEvent>(_onRegisterTeacher);
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event, Emitter<UpdateProfileInfoState> emit) async {
    emit(UpdateProfileInfoLoading());
    if (event.avatar == null && event.currentAvatar != null) {
      await _userRepository
          .updateProfile(
        fullName: event.fullName,
        introduction: event.introduction,
        avatar: event.currentAvatar!,
        speaking: event.speaking,
        learning: event.learning,
      )
          .then(
        (result) async {
          await result.fold(
            (failure) {
              emit(UpdateProfileInfoFailure(message: failure.message));
            },
            (_) async {
              if (event.teaching != null) {
                await _userRepository
                    .updateTeacherTeaching(teaching: event.teaching!)
                    .then((result) {
                  result.fold(
                    (failure) {
                      emit(UpdateProfileInfoFailure(message: failure.message));
                    },
                    (_) {
                      emit(UpdateProfileInfoSuccess());
                    },
                  );
                });
              } else {
                emit(UpdateProfileInfoSuccess());
              }
            },
          );
        },
      );
    } else if (event.currentAvatar == null && event.avatar != null) {
      await _mediaRepository.uploadImage(event.avatar!).then(
        (imageResult) async {
          await imageResult.fold(
            (failure) {
              emit(UpdateProfileInfoFailure(message: failure.message));
            },
            (avatar) async {
              await _userRepository
                  .updateProfile(
                fullName: event.fullName,
                introduction: event.introduction,
                avatar: avatar.id,
                speaking: event.speaking,
                learning: event.learning,
              )
                  .then(
                (result) async {
                  await result.fold(
                    (failure) {
                      emit(UpdateProfileInfoFailure(message: failure.message));
                    },
                    (_) async {
                      if (event.teaching != null) {
                        await _userRepository
                            .updateTeacherTeaching(teaching: event.teaching!)
                            .then((result) {
                          result.fold(
                            (failure) {
                              emit(UpdateProfileInfoFailure(
                                  message: failure.message));
                            },
                            (_) {
                              emit(UpdateProfileInfoSuccess());
                            },
                          );
                        });
                      } else {
                        emit(UpdateProfileInfoSuccess());
                      }
                    },
                  );
                },
              );
            },
          );
        },
      );
    } else {
      emit(const UpdateProfileInfoFailure(message: 'There are some errors'));
    }
  }

  Future<void> _onRegisterTeacher(
      RegisterTeacherEvent event, Emitter<UpdateProfileInfoState> emit) async {
    await _userRepository.registerTeacher(teaching: event.teach).then((result) {
      result.fold(
        (failure) {
          emit(UpdateProfileInfoFailure(message: failure.message));
        },
        (_) {
          emit(UpdateProfileInfoSuccess());
        },
      );
    });
  }

  final UserRepository _userRepository;
  final MediaRepository _mediaRepository;
}
