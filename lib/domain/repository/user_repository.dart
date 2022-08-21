import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/language.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> updateProfile({
    required String fullName,
    required String avatar,
    required String introduction,
    required List<Language> speaking,
    required List<Language> learning,
  });

  Future<Either<Failure, User>> getUserProfile({
    required String userId,
  });
}
