import 'package:exchange_language_mobile/domain/entities/group.dart';

import 'package:exchange_language_mobile/data/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/domain/entities/language.dart';

import '../../domain/repository/group_repository.dart';
import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/group_rest_client.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRestClient _groupRestClient = AppApiService().groupRestClient;
  @override
  Future<Either<Failure, ListGroup>> fetchGroups({int? skip}) async {
    try {
      final response = await _groupRestClient.fetchGroup(skip: skip);
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
  Future<Either<Failure, Group>> fetchGroupDetail(
      {required String slug}) async {
    try {
      final response = await _groupRestClient.fetchGroupDetail(slug: slug);
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
  Future<Either<Failure, void>> createGroup({
    required String title,
    required String thumbnailId,
    required String description,
    required List<Language> topics,
  }) async {
    try {
      final response = await _groupRestClient.createGroup({
        'title': title,
        'thumbnail': thumbnailId,
        'description': description,
        'topics': topics.map((e) => e.id).toList(),
      });
      if (response.error == false) {
        return const Right(null);
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinGroup({required String groupId}) async {
    try {
      final response = await _groupRestClient.joinGroup(groupId: groupId);
      if (response.error == false) {
        return const Right(null);
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
