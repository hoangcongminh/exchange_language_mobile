part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<Message> messages;
  final bool isScroll;
  final Conversation conversation;
  const ConversationLoaded({
    required this.messages,
    required this.isScroll,
    required this.conversation,
  });

  @override
  List<Object> get props => [messages, isScroll, conversation];
}

class ConversationLoading extends ConversationState {}

class ConversationFailure extends ConversationState {}
