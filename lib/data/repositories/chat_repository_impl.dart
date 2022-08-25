import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/repository/chat_repository.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/chat_rest_client.dart';
import '../failure.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRestCient _chatRestClient = AppApiService().chatRestCient;

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    try {
      final response = await _chatRestClient.getConversation();
      if (response.error == false) {
        return Right(response.data!.map((e) => e.toEntity()).toList());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DataMessage>> getMessagesByConversation({
    required String conversationId,
    int? skip,
    int? limit,
  }) async {
    try {
      final response = await _chatRestClient.getMessageByConversation(
          conversationId: conversationId, skip: skip, limit: limit);
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DataMessage>> createOrGetMessageByUserId(
      {required String userId}) async {
    try {
      final response =
          await _chatRestClient.createOrGetMessageByUserId(userId: userId);
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Conversation>> createConversation({
    String? thumbnailId,
    required String groupChatName,
    required List<String> memberIds,
  }) async {
    try {
      final response = await _chatRestClient.createConversation({
        'name': groupChatName,
        'members': memberIds,
        'avatar': thumbnailId,
      });
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
