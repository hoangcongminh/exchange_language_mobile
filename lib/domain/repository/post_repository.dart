import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, ListPost>> fetchPosts({required String groupId});
}
