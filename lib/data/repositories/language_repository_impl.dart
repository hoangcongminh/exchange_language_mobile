import 'package:exchange_language_mobile/data/datasources/remote/language_rest_client.dart';
import 'package:exchange_language_mobile/domain/entities/language.dart';
import 'package:exchange_language_mobile/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/domain/repository/language_repository.dart';

import '../datasources/remote/app_api_service.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageRestClient _languageRestClient =
      AppApiService().languageRestClient;

  @override
  Future<Either<Failure, List<Language>>> getLanguages() async {
    try {
      final response = await _languageRestClient.getListLanguage();
      if (response.error == false) {
        return Right(response.data!.map((e) => e.toEntity()).toList());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
