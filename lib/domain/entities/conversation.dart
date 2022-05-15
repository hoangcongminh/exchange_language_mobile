import 'package:equatable/equatable.dart';

import 'user.dart';

class Conversation extends Equatable {
  final String id;
  final String conversationName;
  final List<User> users;

  const Conversation({
    required this.id,
    required this.conversationName,
    required this.users,
  });

  @override
  List<Object?> get props => [id, conversationName, users];
}
