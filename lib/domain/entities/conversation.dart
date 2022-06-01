import 'package:equatable/equatable.dart';

import 'user.dart';

class Conversation extends Equatable {
  final String id;
  final String? conversationName;
  final List<User> members;
  final DateTime modifiedAt;

  const Conversation({
    required this.id,
    this.conversationName,
    required this.members,
    required this.modifiedAt,
  });

  @override
  List<Object?> get props => [id, conversationName, members, modifiedAt];
}
