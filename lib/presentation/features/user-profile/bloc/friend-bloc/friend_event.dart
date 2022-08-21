part of 'friend_bloc.dart';

abstract class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object> get props => [];
}

class CheckFriendEvent extends FriendEvent {
  final String userId;
  const CheckFriendEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AddFriendEvent extends FriendEvent {
  final String userId;
  const AddFriendEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class ConfirmFriendRequest extends FriendEvent {
  final String userId;
  const ConfirmFriendRequest({required this.userId});

  @override
  List<Object> get props => [userId];
}

class CancelFriendRequest extends FriendEvent {
  final String userId;
  const CancelFriendRequest({required this.userId});

  @override
  List<Object> get props => [userId];
}

class DeleteFriend extends FriendEvent {
  final String userId;
  const DeleteFriend({required this.userId});

  @override
  List<Object> get props => [userId];
}
