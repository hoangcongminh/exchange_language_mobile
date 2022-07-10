import 'package:dartz/dartz.dart';

import '../../domain/repository/blog_repository.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/blog_rest_client.dart';
import '../failure.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRestClient _blogRestClient = AppApiService().blogRestClient;

  @override
  Future<Either<Failure, String>> createBlog() async {
    try {
      final response = await _blogRestClient.createBlog({});
      if (response.error == false) {
        return Right(response.data!);
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
