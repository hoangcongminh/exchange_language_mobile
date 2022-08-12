import 'package:dartz/dartz.dart';

import 'package:exchange_language_mobile/data/failure.dart';
import 'package:exchange_language_mobile/domain/repository/post_repository.dart';

import '../../domain/entities/post.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/post_rest_client.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRestClient _postRestClient = AppApiService().postRestClient;

  @override
  Future<Either<Failure, ListPost>> fetchPosts(
      {required String groupId}) async {
    try {
      final response = await _postRestClient.fetchPosts(groupId: groupId);
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
