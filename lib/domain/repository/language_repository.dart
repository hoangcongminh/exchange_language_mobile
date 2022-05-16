import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/language.dart';

abstract class LanguageRepository {
  Future<Either<Failure, List<Language>>> getLanguages();
}
