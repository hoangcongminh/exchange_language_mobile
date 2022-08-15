import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/comment.dart';

abstract class CommentRepository {
  Future<Either<Failure, ListComment>> fetchComment({required String postId});
  Future<Either<Failure, void>> commentToPost({
    required String postId,
    required String content,
    String? idCommentReply,
  });
}
