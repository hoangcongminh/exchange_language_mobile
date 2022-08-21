import 'package:dartz/dartz.dart';

import '../../domain/entities/language.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/user_rest_client.dart';
import '../failure.dart';
import '../models/api_response_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRestClient _userRestClient = AppApiService().userRestClient;
  @override
  Future<Either<Failure, void>> updateProfile({
    required String fullName,
    required String avatar,
    required String introduction,
    required List<Language> speaking,
    required List<Language> learning,
    List<Language>? teaching,
  }) async {
    try {
      ApiResponseModel<dynamic> response;
      if (teaching == null) {
        response = await _userRestClient.updateProfile({
          'fullname': fullName,
          'avatar': avatar,
          'introduction': introduction,
          'speak': speaking.map((e) => e.id).toList(),
          'learn': learning.map((e) => e.id).toList(),
        });
      } else {
        response = await _userRestClient.updateProfile({
          'fullname': fullName,
          'avatar': avatar,
          'introduction': introduction,
          'speak': speaking.map((e) => e.id).toList(),
          'learn': learning.map((e) => e.id).toList(),
          'teach': teaching.map((e) => e.id).toList(),
        });
      }

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

  @override
  Future<Either<Failure, User>> getUserProfile({required String userId}) async {
    try {
      final response = await _userRestClient.getUserProfile(userId: userId);
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerTeacher(
      {required List<Language> teaching}) async {
    try {
      final response = await _userRestClient.registerTeacher({
        'teach': teaching.map((e) => e.id).toList(),
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
