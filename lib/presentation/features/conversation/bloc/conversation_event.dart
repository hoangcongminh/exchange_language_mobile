part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class FetchMessage extends ConversationEvent {
  final String conversationId;

  const FetchMessage({required this.conversationId});
}

class ReceiveNewMessage extends ConversationEvent {
  final Message message;

  const ReceiveNewMessage(this.message);
}

class SendMessage extends ConversationEvent {
  final String conversationId;
  final String content;

  const SendMessage(this.conversationId, this.content);
}
