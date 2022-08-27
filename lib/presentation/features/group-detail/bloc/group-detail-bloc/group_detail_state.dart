part of 'group_detail_bloc.dart';

abstract class GroupDetailState extends Equatable {
  const GroupDetailState();

  @override
  List<Object> get props => [];
}

class GroupDetailInitial extends GroupDetailState {}

class GroupDetailLoading extends GroupDetailState {}

class GroupDetailLoaded extends GroupDetailState {
  final Group group;
  const GroupDetailLoaded({required this.group});

  @override
  List<Object> get props => [group];
}

class GroupDetailFailure extends GroupDetailState {
  final String message;
  const GroupDetailFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class GroupDetailJoinSuccess extends GroupDetailState {
  final String groupId;

  const GroupDetailJoinSuccess(this.groupId);

  @override
  List<Object> get props => [groupId];
}

class GroupDetailLeaveSuccess extends GroupDetailState {}
