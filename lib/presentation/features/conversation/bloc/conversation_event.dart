part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class FetchMessage extends ConversationEvent {
  final String conversationId;
  final int? skip;

  const FetchMessage({
    required this.conversationId,
    this.skip,
  });

  @override
  List<Object> get props => [conversationId];
}

class RefreshMessage extends ConversationEvent {
  final String conversationId;

  const RefreshMessage({
    required this.conversationId,
  });

  @override
  List<Object> get props => [conversationId];
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
