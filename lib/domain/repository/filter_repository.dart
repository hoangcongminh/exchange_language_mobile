import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/language.dart';
import '../entities/user.dart';

abstract class FilterRepository {
  Future<Either<Failure, List<User>>> searchUsers({
    required int type,
    required List<Language> speakingLanguages,
    required List<Language> learningLanguages,
  });
}
