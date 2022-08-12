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

class GroupDetailLoadFailure extends GroupDetailState {}

class GroupDetailJoinSuccess extends GroupDetailState {}

class GroupDetailJoinFailure extends GroupDetailState {}
