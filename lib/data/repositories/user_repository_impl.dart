import 'package:dartz/dartz.dart';

import '../../domain/entities/language.dart';
import '../../domain/repository/user_repository.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/user_rest_client.dart';
import '../failure.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRestClient _userRestClient = AppApiService().userRestClient;
  @override
  Future<Either<Failure, void>> updateProfile({
    required String fullName,
    required String avatar,
    required String introduction,
    required List<Language> speaking,
    required List<Language> learning,
  }) async {
    try {
      final response = await _userRestClient.updateProfile({
        'fullname': fullName,
        'avatar': avatar,
        'introduction': introduction,
        'speak': speaking.map((e) => e.id).toList(),
        'learn': learning.map((e) => e.id).toList(),
      });
      if (response.error == false) {
        return const Right(null);
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
