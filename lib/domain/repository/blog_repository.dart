import 'package:dartz/dartz.dart';

import '../../data/failure.dart';

abstract class BlogRepository {
  Future<Either<Failure, String>> createBlog();

  Future<Either<Failure, String>> fetchBlogs();
}
