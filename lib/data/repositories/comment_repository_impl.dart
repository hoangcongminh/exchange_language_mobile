import 'package:exchange_language_mobile/data/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/entities/comment.dart';
import '../../domain/repository/comment_repository.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/comment_rest_client.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRestClient _commentRestClient =
      AppApiService().commentRestClient;
  @override
  Future<Either<Failure, ListComment>> fetchComment(
      {required String postId}) async {
    try {
      final response = await _commentRestClient.fetchComment(postId: postId);
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> commentToPost(
      {required String postId,
      required String content,
      String? idCommentReply}) async {
    try {
      final response = await _commentRestClient.commentToPost(
        {'content': content, 'idReply': idCommentReply},
        postId: postId,
      );
      if (response.error == false) {
        return const Right(null);
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
