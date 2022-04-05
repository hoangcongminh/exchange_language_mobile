import 'package:exchange_language_mobile/data/exception.dart';
import 'package:exchange_language_mobile/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';

import '../../domain/repository/auth_repository.dart';
import '../datasources/local/user_local_data.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/auth_rest_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRestClient _authRestClient = AppApiService().authRestClient;

  AuthRepositoryImpl();

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final response =
          await _authRestClient.login({'email': email, 'password': password});
      if (response.error == false) {
        UserLocal().setAccessToken(response.data!);
        return Right(response.data!);
      } else {
        String message = response.message!;
        if (message == 'wrong_password') {
          return const Left(ServerFailure('Wrong password'));
        } else {
          return const Left(ServerFailure('Email not exists'));
        }
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> refreshToken() async {
    final response = await _authRestClient.refreshToken();
    if (response.error == false) {
      return Right(response.data!.toEntity());
    } else {
      return const Left(ServerFailure('Refresh token failed'));
    }
    // try {
    //   final result = await _authRestClient.refreshToken();
    //   return Right(result.data!.toEntity());
    // } on ServerException {
    //   return const Left(ServerFailure(''));
    // }
  }

  @override
  Future<Either<Failure, String>> register(
      String email, String password, String fullName) async {
    try {
      final result = await _authRestClient.register(
          {'email': email, 'password': password, 'fullName': fullName});
      return Right(result.data!);
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, void>> sendOTP(String email) async {
    final response = await _authRestClient.sendOTP({'email': email});
    if (response.error == false) {
      return const Right(null);
    } else {
      return const Left(ServerFailure('Send OTP failed'));
    }
    // try {
    //   final result = await _authRestClient.sendOTP({'email': email});
    //   return Right(result);
    // } on ServerException {
    //   return const Left(ServerFailure(''));
    // }
  }

  @override
  Future<Either<Failure, void>> verifyOTP(String email, String otp) async {
    final response =
        await _authRestClient.verifyOTP({'email': email, 'otp': otp});
    if (response.error == false) {
      return const Right(null);
    } else {
      return const Left(ServerFailure('Verify OTP failed'));
    }
    // try {
    //   final result =
    //       await _authRestClient.verifyOTP({'email': email, 'otp': otp});
    //   return Right(result);
    // } on ServerException {
    //   return const Left(ServerFailure(''));
    // }
  }
}
