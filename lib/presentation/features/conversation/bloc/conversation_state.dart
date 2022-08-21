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
  final String conversationId;
  const ConversationLoaded({
    required this.messages,
    required this.isScroll,
    required this.conversationId,
  });

  @override
  List<Object> get props => [messages, isScroll];
}

class ConversationLoading extends ConversationState {}

class ConversationFailure extends ConversationState {}
