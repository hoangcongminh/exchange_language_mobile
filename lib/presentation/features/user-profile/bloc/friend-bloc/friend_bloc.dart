import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/domain/repository/friend_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc(this._friendRepository)
      : super(const FriendState(friendStatus: FriendStatus.LOADNG)) {
    on<FriendEvent>((event, emit) {});
    on<CheckFriendEvent>(_checkFriend);
    on<AddFriendEvent>(_addFriend);
    on<ConfirmFriendRequest>(_confirmFriendRequest);
    on<CancelFriendRequest>(_cancelFriendRequest);
    on<DeleteFriend>(_deleteFriend);
  }

  Future<void> _checkFriend(
      CheckFriendEvent event, Emitter<FriendState> emit) async {
    emit(const FriendState(friendStatus: FriendStatus.LOADNG));
    await _friendRepository.checkFriend(userId: event.userId).then((result) {
      result.fold(
        (failure) {
          emit(const FriendState(friendStatus: FriendStatus.NOT_FRIEND));
        },
        (friendStatus) {
          switch (friendStatus) {
            case 0:
              emit(const FriendState(friendStatus: FriendStatus.NOT_FRIEND));
              break;
            case 1:
              emit(const FriendState(friendStatus: FriendStatus.FRIEND));
              break;
            case 2:
              emit(const FriendState(friendStatus: FriendStatus.RECEIVER));
              break;
            case 3:
              emit(const FriendState(friendStatus: FriendStatus.SENDER));
              break;
          }
        },
      );
    });
  }

  Future<void> _addFriend(
      AddFriendEvent event, Emitter<FriendState> emit) async {
    emit(const FriendState(friendStatus: FriendStatus.LOADNG));
    await _friendRepository.addFriend(userId: event.userId).then((result) {
      result.fold(
        (failure) {
          emit(const FriendState(friendStatus: FriendStatus.NOT_FRIEND));
        },
        (friendStatus) {
          switch (friendStatus) {
            case 0:
              emit(state.copyWith(friendStatus: FriendStatus.NOT_FRIEND));
              break;
            case 1:
              emit(state.copyWith(friendStatus: FriendStatus.FRIEND));
              break;
            case 2:
              emit(state.copyWith(friendStatus: FriendStatus.RECEIVER));
              break;
            case 3:
              emit(state.copyWith(friendStatus: FriendStatus.SENDER));
              break;
          }
        },
      );
    });
  }

  Future<void> _confirmFriendRequest(
      ConfirmFriendRequest event, Emitter<FriendState> emit) async {
    emit(const FriendState(friendStatus: FriendStatus.LOADNG));
    await _friendRepository
        .confirmFriendRequest(userId: event.userId)
        .then((result) {
      result.fold(
        (failure) {
          emit(const FriendState(friendStatus: FriendStatus.NOT_FRIEND));
        },
        (friendStatus) {
          switch (friendStatus) {
            case 0:
              emit(state.copyWith(friendStatus: FriendStatus.NOT_FRIEND));
              break;
            case 1:
              emit(state.copyWith(friendStatus: FriendStatus.FRIEND));
              break;
            case 2:
              emit(state.copyWith(friendStatus: FriendStatus.RECEIVER));
              break;
            case 3:
              emit(state.copyWith(friendStatus: FriendStatus.SENDER));
              break;
          }
        },
      );
    });
  }

  Future<void> _cancelFriendRequest(
      CancelFriendRequest event, Emitter<FriendState> emit) async {
    emit(const FriendState(friendStatus: FriendStatus.LOADNG));
    await _friendRepository
        .cancelFriendRequest(userId: event.userId)
        .then((result) {
      result.fold(
        (failure) {
          emit(const FriendState(friendStatus: FriendStatus.NOT_FRIEND));
        },
        (friendStatus) {
          switch (friendStatus) {
            case 0:
              emit(state.copyWith(friendStatus: FriendStatus.NOT_FRIEND));
              break;
            case 1:
              emit(state.copyWith(friendStatus: FriendStatus.FRIEND));
              break;
            case 2:
              emit(state.copyWith(friendStatus: FriendStatus.RECEIVER));
              break;
            case 3:
              emit(state.copyWith(friendStatus: FriendStatus.SENDER));
              break;
          }
        },
      );
    });
  }

  Future<void> _deleteFriend(
      DeleteFriend event, Emitter<FriendState> emit) async {
    emit(const FriendState(friendStatus: FriendStatus.LOADNG));
    await _friendRepository.deleteFriend(userId: event.userId).then((result) {
      result.fold(
        (failure) {
          emit(const FriendState(friendStatus: FriendStatus.NOT_FRIEND));
        },
        (friendStatus) {
          switch (friendStatus) {
            case 0:
              emit(state.copyWith(friendStatus: FriendStatus.NOT_FRIEND));
              break;
            case 1:
              emit(state.copyWith(friendStatus: FriendStatus.FRIEND));
              break;
            case 2:
              emit(state.copyWith(friendStatus: FriendStatus.RECEIVER));
              break;
            case 3:
              emit(state.copyWith(friendStatus: FriendStatus.SENDER));
              break;
          }
        },
      );
    });
  }

  final FriendRepository _friendRepository;
}
