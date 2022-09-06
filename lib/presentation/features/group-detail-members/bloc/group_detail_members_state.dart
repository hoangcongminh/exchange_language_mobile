part of 'group_detail_members_bloc.dart';

abstract class GroupDetailMembersState extends Equatable {
  const GroupDetailMembersState();

  @override
  List<Object> get props => [];
}

class GroupDetailMembersInitial extends GroupDetailMembersState {}

class GroupDetailMembersLoading extends GroupDetailMembersState {}

class GroupDetailMembersLoaded extends GroupDetailMembersState {
  final List<User> requests;

  const GroupDetailMembersLoaded({
    required this.requests,
  });

  @override
  List<Object> get props => [requests];
}

class GroupDetailMembersFailure extends GroupDetailMembersState {
  final String message;

  const GroupDetailMembersFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
