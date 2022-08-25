import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/user.dart';
import '../../../../../domain/repository/user_repository.dart';
import '../../../../common/app_bloc.dart';
import '../friend-bloc/friend_bloc.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(this._userRepository) : super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) {});
    on<GetUserProfileEvent>(_getUserProfile);
    on<RateTeacherEvent>(_rateTeacher);
  }

  Future<void> _getUserProfile(
      GetUserProfileEvent event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    await _userRepository.getUserProfile(userId: event.userId).then((result) {
      result.fold((failure) {
        emit(UserProfileLoadFailure(message: failure.message));
      }, (user) {
        if (user.id != UserLocal().getUser()!.id) {
          AppBloc.friendBloc.add(CheckFriendEvent(userId: user.id));
        }
        if (user.role == 1) {
          int starSum = 0;
          int rated = 0;
          for (Rate star in user.teacher?.rate ?? []) {
            if (star.author == UserLocal().getUser()!.id) {
              rated = star.star;
            }
            starSum += star.star;
          }
          emit(UserProfileLoaded(
            user: user,
            star: starSum == 0 ? 0 : starSum ~/ user.teacher!.rate.length,
            rated: rated,
          ));
        } else {
          emit(UserProfileLoaded(user: user));
        }
      });
    });
  }

  Future<void> _rateTeacher(
      RateTeacherEvent event, Emitter<UserProfileState> emit) async {
    await _userRepository
        .rateTeacher(userId: event.userId, star: event.star)
        .then(
      (result) {
        result.fold(
          (failure) {
            return null;
          },
          (_) {
            return null;
          },
        );
      },
    );
  }

  final UserRepository _userRepository;
}
