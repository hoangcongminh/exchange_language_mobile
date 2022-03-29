import 'package:dartz/dartz.dart';

import '../../data/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String email, String password);
}
