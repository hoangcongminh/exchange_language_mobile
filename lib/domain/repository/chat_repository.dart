import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/data/failure.dart';
import 'package:exchange_language_mobile/domain/entities/conversation.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Conversation>>> getConversations();
}
