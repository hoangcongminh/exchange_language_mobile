part of 'friend_list_bloc.dart';

abstract class FriendListState extends Equatable {
  const FriendListState();

  @override
  List<Object> get props => [];
}

class FriendListInitial extends FriendListState {}

class FriendListLoading extends FriendListState {}

class FriendListLoaded extends FriendListState {
  final List<User> friends;
  const FriendListLoaded({required this.friends});
  @override
  List<Object> get props => [friends];
}

class FriendListLoadFailure extends FriendListState {}
