import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/group.dart';
import '../entities/language.dart';

abstract class GroupRepository {
  Future<Either<Failure, ListGroup>> fetchGroups({int? skip});

  Future<Either<Failure, Group>> fetchGroupDetail({required String slug});

  Future<Either<Failure, void>> createGroup({
    required String title,
    required String thumbnailId,
    required String description,
    required List<Language> topics,
  });

  Future<Either<Failure, void>> joinGroup({required String groupId});

  Future<Either<Failure, void>> leaveGroup({required String groupId});
}
