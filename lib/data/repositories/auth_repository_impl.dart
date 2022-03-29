import 'package:exchange_language_mobile/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../domain/repository/auth_repository.dart';
import '../datasources/remote/app_api_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppApiService appApiService;

  AuthRepositoryImpl(this.appApiService);

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final result = await appApiService.authRestClient
          .login({'email': email, 'password': password});
      return Right(result.data!);
    } on Exception {
      return const Left(ServerFailure(''));
    }
  }
}
