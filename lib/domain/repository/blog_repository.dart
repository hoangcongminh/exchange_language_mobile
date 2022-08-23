import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/blog.dart';

abstract class BlogRepository {
  Future<Either<Failure, void>> createBlog({
    required String title,
    required String content,
    required String thumbnailId,
  });

  Future<Either<Failure, String>> editBlog({
    required String blogId,
    required String title,
    required String content,
    required String thumbnailId,
  });

  Future<Either<Failure, void>> deleteBlog({
    required String blogId,
  });

  Future<Either<Failure, ListBlog>> fetchBlogs({int? skip});

  Future<Either<Failure, Blog>> getBlogDetail({required String slug});
}
