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

class CreateOrGetMessage extends ConversationEvent {
  final String userId;
  const CreateOrGetMessage({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class ReceiveNewMessage extends ConversationEvent {
  final Message message;

  const ReceiveNewMessage(this.message);
}

class SendMessage extends ConversationEvent {
  final String conversationId;
  final String content;

  const SendMessage({
    required this.conversationId,
    required this.content,
  });
}

class SendAudioMessage extends ConversationEvent {
  final String conversationId;
  final File audio;

  const SendAudioMessage({
    required this.conversationId,
    required this.audio,
  });
}

class SendIconMessage extends ConversationEvent {
  final String conversationId;
  final String content;

  const SendIconMessage({
    required this.conversationId,
    required this.content,
  });
}
