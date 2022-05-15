import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String email, String password);

  Future<Either<Failure, User>> refreshToken();

  Future<Either<Failure, String>> sendOTP(String email, bool isForgotPassword);

  Future<Either<Failure, String>> verifyOTP(String email, String otp);

  Future<Either<Failure, String>> register(
      String email, String password, String fullName, String avatar);

  Future<Either<Failure, String>> resetPassword(String email, String password);

  Future<void> logout();
}
