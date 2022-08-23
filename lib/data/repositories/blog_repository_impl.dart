import 'package:dartz/dartz.dart';

import '../../domain/entities/blog.dart';
import '../../domain/repository/blog_repository.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/blog_rest_client.dart';
import '../failure.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRestClient _blogRestClient = AppApiService().blogRestClient;

  @override
  Future<Either<Failure, void>> createBlog({
    required String title,
    required String content,
    required String thumbnailId,
  }) async {
    try {
      final response = await _blogRestClient.createBlog({
        'title': title,
        'content': content,
        'thumbnail': thumbnailId,
      });
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
  Future<Either<Failure, ListBlog>> fetchBlogs({int? skip}) async {
    try {
      final response = await _blogRestClient.fetchBlogs(skip: skip);
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Blog>> getBlogDetail({required String slug}) async {
    try {
      final response = await _blogRestClient.fetchBlogDetail(slug);
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> editBlog({
    required String blogId,
    required String title,
    required String content,
    required String thumbnailId,
  }) async {
    try {
      final response = await _blogRestClient.editBlog(blogId, {
        'title': title,
        'content': content,
        'thumbnail': thumbnailId,
      });
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

  @override
  Future<Either<Failure, void>> deleteBlog({required String blogId}) async {
    try {
      final response = await _blogRestClient.deleteBlog(blogId);
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
