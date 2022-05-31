import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/conversation.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Conversation>>> getConversations();

  Future<Either<Failure, List<Message>>> getMessagesByConversation(
      String conversationId);
}
