import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../domain/entities/language.dart';
import '../../../../domain/entities/user.dart';
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
        (result) {
          result.fold(
            (failure) {
              emit(UpdateProfileInfoFailure(message: failure.message));
            },
            (_) {
              emit(UpdateProfileInfoSuccess());
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
                (result) {
                  result.fold(
                    (failure) {
                      emit(UpdateProfileInfoFailure(message: failure.message));
                    },
                    (_) {
                      emit(UpdateProfileInfoSuccess());
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

  final UserRepository _userRepository;
  final MediaRepository _mediaRepository;
}
