import 'package:exchange_language_mobile/data/exception.dart';
import 'package:exchange_language_mobile/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';

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
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, User>> refreshToken() async {
    try {
      final result = await appApiService.authRestClient.refreshToken();
      return Right(result.data!.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> register(
      String email, String password, String fullName) async {
    try {
      final result = await appApiService.authRestClient.register(
          {'email': email, 'password': password, 'fullName': fullName});
      return Right(result.data!);
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, void>> sendOTP(String email) async {
    try {
      final result =
          await appApiService.authRestClient.sendOTP({'email': email});
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOTP(String email, String otp) async {
    try {
      final result = await appApiService.authRestClient
          .verifyOTP({'email': email, 'otp': otp});
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }
}
