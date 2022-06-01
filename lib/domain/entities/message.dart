import 'package:equatable/equatable.dart';

import '../../data/datasources/local/user_local_data.dart';
import 'user.dart';

class Message extends Equatable {
  final DateTime createdAt;
  final String id;
  final User author;
  final String conversationId;
  final String? content;

  const Message({
    required this.createdAt,
    required this.id,
    required this.author,
    required this.conversationId,
    required this.content,
  });

  @override
  List<Object?> get props => [createdAt, id, author, conversationId, content];
  bool get isMe => author.id == UserLocal().getUser()!.id;
}
