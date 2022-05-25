import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/user.dart';

abstract class FilterRepository {
  Future<Either<Failure, List<User>>> searchUsers();
}
