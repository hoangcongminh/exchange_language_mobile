import 'package:dartz/dartz.dart';

import '../../data/failure.dart';

abstract class BlogRepository {
  Future<Either<Failure, String>> createBlog();
}
