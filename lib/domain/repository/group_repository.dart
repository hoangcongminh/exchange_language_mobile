import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/group.dart';

abstract class GroupRepository {
  Future<Either<Failure, ListGroup>> fetchGroups({int? skip});
}
