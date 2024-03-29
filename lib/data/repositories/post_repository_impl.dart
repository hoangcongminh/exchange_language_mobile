import 'package:dartz/dartz.dart';

import 'package:exchange_language_mobile/data/failure.dart';
import 'package:exchange_language_mobile/domain/repository/post_repository.dart';

import '../../domain/entities/post.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/post_rest_client.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRestClient _postRestClient = AppApiService().postRestClient;

  @override
  Future<Either<Failure, ListPost>> fetchPosts({
    required String groupId,
    int? skip,
    int? limit,
  }) async {
    try {
      final response = await _postRestClient.fetchPosts(
        groupId: groupId,
        skip: skip,
        limit: limit,
      );
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
  Future<Either<Failure, void>> createPost({
    required String groupId,
    required String postTitle,
    required String postContent,
  }) async {
    try {
      final response = await _postRestClient.createPost({
        'title': postTitle,
        'content': postContent,
      }, groupId: groupId);
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

  @override
  Future<Either<Failure, void>> likePost({required postId}) async {
    try {
      final response = await _postRestClient.likePost(postId: postId);
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

  @override
  Future<Either<Failure, ListPost>> searchPost(
      {required String groupId, required String searchTitle}) async {
    try {
      final response = await _postRestClient.searchPost(
          groupId: groupId, searchTitle: searchTitle);
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
  Future<Either<Failure, Post>> getPostDetail({required String postId}) async {
    try {
      final response = await _postRestClient.getDetailPost(postId: postId);
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
}
