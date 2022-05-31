part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<Message> messages;
  const ConversationLoaded({
    required this.messages,
  });
}

class ConversationLoading extends ConversationState {}

class ConversationFailure extends ConversationState {}
