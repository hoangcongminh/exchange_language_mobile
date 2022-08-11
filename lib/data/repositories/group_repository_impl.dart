import 'package:exchange_language_mobile/domain/entities/group.dart';

import 'package:exchange_language_mobile/data/failure.dart';

import 'package:dartz/dartz.dart';

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
}
