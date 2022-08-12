part of 'create_group_bloc.dart';

abstract class CreateGroupState extends Equatable {
  const CreateGroupState();

  @override
  List<Object> get props => [];
}

class CreateGroupInitial extends CreateGroupState {}

class CreateGroupLoading extends CreateGroupState {}

class CreateGroupSuccess extends CreateGroupState {}

class CreateGroupFailure extends CreateGroupState {
  final String message;
  const CreateGroupFailure({required this.message});

  @override
  List<Object> get props => [message];
}
