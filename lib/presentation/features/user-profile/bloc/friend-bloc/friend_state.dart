part of 'friend_bloc.dart';

enum FriendStatus {
  LOADNG,
  NOT_FRIEND,
  FRIEND,
  RECEIVER,
  SENDER,
}

class FriendState extends Equatable {
  final FriendStatus friendStatus;
  const FriendState({required this.friendStatus});

  @override
  List<Object> get props => [friendStatus];

  FriendState copyWith({
    FriendStatus? friendStatus,
  }) {
    return FriendState(
      friendStatus: friendStatus ?? this.friendStatus,
    );
  }
}
