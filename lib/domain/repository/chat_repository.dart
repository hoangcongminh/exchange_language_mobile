import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/conversation.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Conversation>>> getConversations();
}
