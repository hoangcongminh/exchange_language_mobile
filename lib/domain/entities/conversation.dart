import 'package:equatable/equatable.dart';

import 'message.dart';
import 'user.dart';

class Conversation extends Equatable {
  final String id;
  final String? conversationName;
  final List<User> members;
  final DateTime modifiedAt;
  final Message? lastMessage;

  const Conversation({
    required this.id,
    this.conversationName,
    required this.members,
    required this.modifiedAt,
    this.lastMessage,
  });

  @override
  List<Object?> get props => [id, conversationName, members, modifiedAt];
}
