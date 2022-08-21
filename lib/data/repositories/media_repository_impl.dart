import 'package:exchange_language_mobile/data/datasources/remote/media_rest_client.dart';
import 'package:exchange_language_mobile/domain/entities/media.dart';
import 'package:exchange_language_mobile/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';

import 'package:exchange_language_mobile/domain/repository/media_repository.dart';

import '../datasources/remote/app_api_service.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaRestClient _authRestClient = AppApiService().mediaRestClient;

  @override
  Future<Either<Failure, Media>> uploadImage(File image) async {
    try {
      final response = await _authRestClient.uploadImage(image);
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Media>> uploadAudio(File audio) async {
    try {
      final response = await _authRestClient.uploadAudio(audio);
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
