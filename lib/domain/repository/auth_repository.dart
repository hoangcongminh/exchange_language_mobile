import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/data/failure.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String email, String password);

  Future<Either<Failure, User>> refreshToken();

  Future<Either<Failure, String>> sendOTP(String email);

  Future<Either<Failure, String>> verifyOTP(String email, String otp);

  Future<Either<Failure, String>> register(
      String email, String password, String fullName, File avatar);

  Future<void> logout();
}
