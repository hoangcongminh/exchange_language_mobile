import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/user.dart';
import '../../../../domain/repository/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(this._userRepository) : super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) {});
    on<GetUserProfileEvent>(_getUserProfile);
  }

  Future<void> _getUserProfile(
      GetUserProfileEvent event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    await _userRepository.getUserProfile(userId: event.userId).then((result) {
      result.fold((failure) {
        emit(UserProfileLoadFailure(message: failure.message));
      }, (user) {
        emit(UserProfileLoaded(user: user));
      });
    });
  }

  final UserRepository _userRepository;
}
