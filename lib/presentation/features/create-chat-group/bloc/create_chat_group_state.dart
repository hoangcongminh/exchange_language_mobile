part of 'create_chat_group_bloc.dart';

abstract class CreateChatGroupState extends Equatable {
  const CreateChatGroupState();

  @override
  List<Object> get props => [];
}

class CreateChatGroupInitial extends CreateChatGroupState {}

class CreateChatGroupLoading extends CreateChatGroupState {}

class CreateChatGroupSuccess extends CreateChatGroupState {
  final Conversation conversation;

  const CreateChatGroupSuccess({required this.conversation});

  @override
  List<Object> get props => [conversation];
}

class CreateChatGroupFailure extends CreateChatGroupState {
  final String message;
  const CreateChatGroupFailure({required this.message});

  @override
  List<Object> get props => [message];
}
