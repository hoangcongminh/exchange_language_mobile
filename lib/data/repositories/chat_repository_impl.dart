import 'package:dartz/dartz.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/repository/chat_repository.dart';
import '../failure.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<Either<Failure, List<Conversation>>> getConversations() {
    // TODO: implement getConversations
    throw UnimplementedError();
  }
}
