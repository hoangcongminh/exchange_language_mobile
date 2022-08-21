import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/user.dart';
import '../../../../../domain/repository/friend_repository.dart';

part 'friend_list_event.dart';
part 'friend_list_state.dart';

class FriendListBloc extends Bloc<FriendListEvent, FriendListState> {
  FriendListBloc(this._friendRepository) : super(FriendListInitial()) {
    on<FriendListEvent>((event, emit) {});
    on<FetchFriendList>(_fetchFriendList);
  }

  Future<void> _fetchFriendList(
      FetchFriendList event, Emitter<FriendListState> emit) async {
    emit(FriendListLoading());
    await _friendRepository.getFriends().then(
      (result) {
        result.fold((failure) {
          emit(FriendListLoadFailure());
        }, (listUser) {
          emit(FriendListLoaded(friends: listUser.users));
        });
      },
    );
  }

  final FriendRepository _friendRepository;
}
