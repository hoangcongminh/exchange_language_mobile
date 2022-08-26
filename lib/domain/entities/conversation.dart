import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/domain/entities/media.dart';

import 'message.dart';
import 'user.dart';

class Conversation extends Equatable {
  final String id;
  final String? conversationName;
  final List<User> members;
  final DateTime modifiedAt;
  final Media? avatar;
  final Message? lastMessage;

  const Conversation({
    required this.id,
    this.conversationName,
    required this.members,
    required this.modifiedAt,
    this.avatar,
    this.lastMessage,
  });

  @override
  List<Object?> get props =>
      [id, conversationName, members, avatar, modifiedAt];
}
