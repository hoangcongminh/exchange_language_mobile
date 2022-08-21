import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';

import '../../data/failure.dart';

abstract class FriendRepository {
  Future<Either<Failure, int>> checkFriend({required String userId});

  Future<Either<Failure, int>> addFriend({required String userId});

  Future<Either<Failure, int>> confirmFriendRequest({required String userId});

  Future<Either<Failure, int>> cancelFriendRequest({required String userId});

  Future<Either<Failure, int>> deleteFriend({required String userId});

  Future<Either<Failure, ListUser>> getFriends();
}
