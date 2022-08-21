import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/domain/entities/conversation.dart';

import '../../data/datasources/local/user_local_data.dart';
import 'user.dart';

class DataMessage extends Equatable {
  final List<Message> messages;
  final Conversation conversationInfo;
  const DataMessage({
    required this.messages,
    required this.conversationInfo,
  });

  @override
  List<Object?> get props => [messages, conversationInfo];
}

class Message extends Equatable {
  final DateTime createdAt;
  final String id;
  final User author;
  final String conversationId;
  final String? content;
  final int? type; //0: text, 1:audio, 2:icon

  const Message({
    required this.createdAt,
    required this.id,
    required this.author,
    required this.conversationId,
    this.content,
    this.type,
  });

  @override
  List<Object?> get props =>
      [createdAt, id, author, conversationId, content, type];
  bool get isMe => author.id == UserLocal().getUser()!.id;
}
