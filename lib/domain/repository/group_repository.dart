import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';

import '../../data/failure.dart';
import '../entities/group.dart';
import '../entities/language.dart';

abstract class GroupRepository {
  Future<Either<Failure, ListGroup>> fetchGroups({int? skip});

  Future<Either<Failure, Group>> fetchGroupDetail({required String groupId});

  Future<Either<Failure, void>> createGroup({
    required String title,
    required String thumbnailId,
    required String description,
    required List<Language> topics,
    required bool isPrivate,
  });

  Future<Either<Failure, void>> joinGroup({required String groupId});

  Future<Either<Failure, List<User>>> getListRequest({required String groupId});

  Future<Either<Failure, void>> cancelRequestJoin({required String groupId});

  Future<Either<Failure, void>> acceptRequestJoin({
    required String groupId,
    required String userId,
  });

  Future<Either<Failure, void>> rejectRequestJoin({
    required String groupId,
    required String userId,
  });

  Future<Either<Failure, void>> leaveGroup({required String groupId});
}
