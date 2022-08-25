import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/conversation.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, Conversation>> createConversation({
    String? thumbnailId,
    required String groupChatName,
    required List<String> memberIds,
  });

  Future<Either<Failure, List<Conversation>>> getConversations();

  Future<Either<Failure, DataMessage>> getMessagesByConversation({
    required String conversationId,
    int? skip,
    int? limit,
  });

  Future<Either<Failure, DataMessage>> createOrGetMessageByUserId({
    required String userId,
  });
}
