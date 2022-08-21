import 'package:dartz/dartz.dart';

import '../../domain/entities/language.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/local/locale_local_data.dart';
import '../datasources/local/user_local_data.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/auth_rest_client.dart';
import '../failure.dart';

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
        await AppApiService().clientSetup();
        return Right(response.data!);
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    LocaleLocal().clearLocale();
    UserLocal().clearUser();
    UserLocal().clearAccessToken();
  }

  @override
  Future<Either<Failure, User>> refreshToken() async {
    try {
      final response = await _authRestClient.refreshToken();
      if (response.error == false) {
        UserLocal().clearUser();
        UserLocal().setUser(response.data!);
        return Right(response.data!.toEntity());
      } else {
        return const Left(ServerFailure('Refresh token failed'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> register(
    String email,
    String password,
    String fullName,
    String avatarId,
    List<Language> speak,
    List<Language> learn,
  ) async {
    try {
      final response = await _authRestClient.register({
        'email': email,
        'password': password,
        'fullname': fullName,
        'avatar': avatarId,
        'speak': speak.map((e) => e.id).toList(),
        'learn': learn.map((e) => e.id).toList(),
      });

      if (response.error == false) {
        UserLocal().setAccessToken(response.data!);
        await AppApiService().clientSetup();

        return Right(response.data!);
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      String email, String password) async {
    try {
      final response = await _authRestClient.resetPassword(
        {
          'email': email,
          'password': password,
        },
      );
      if (response.error == false) {
        return Right(response.message);
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendOTP(
      String email, isForgotPassword) async {
    try {
      final response = await _authRestClient.sendOTP({
        'email': email,
        'isForgotPassword': isForgotPassword,
      });
      if (response.error == false) {
        return Right(response.message);
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOTP(String email, String otp) async {
    try {
      final response =
          await _authRestClient.verifyOTP({'email': email, 'opt': otp});
      if (response.error == false) {
        return Right(response.message);
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
