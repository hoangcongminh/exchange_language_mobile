import 'package:exchange_language_mobile/domain/entities/conversation.dart';
import 'package:exchange_language_mobile/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<Either<Failure, List<Conversation>>> getConversations() {
    // TODO: implement getConversations
    throw UnimplementedError();
  }
}
