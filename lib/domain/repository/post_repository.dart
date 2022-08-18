import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, ListPost>> fetchPosts({
    required String groupId,
    int? skip,
    int? limit,
  });
  Future<Either<Failure, void>> createPost({
    required String groupId,
    required String postTitle,
    required String postContent,
  });
  Future<Either<Failure, void>> likePost({required postId});
  Future<Either<Failure, ListPost>> searchPost({
    required String groupId,
    required String searchTitle,
  });
}
