part of 'group_bloc.dart';

class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final List<Group> groups;

  const GroupLoaded({required this.groups});
}

class GroupLoadFailure extends GroupState {}
