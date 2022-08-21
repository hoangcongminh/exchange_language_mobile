import 'package:exchange_language_mobile/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';
import 'package:exchange_language_mobile/domain/repository/friend_repository.dart';

import '../datasources/remote/app_api_service.dart';
import '../datasources/remote/friend_rest_client.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FriendRestClient _friendRestClient = AppApiService().friendRestClient;
  @override
  Future<Either<Failure, int>> addFriend({required String userId}) async {
    try {
      final response = await _friendRestClient.addFriend(userId: userId);
      if (response.error == false) {
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
  Future<Either<Failure, int>> checkFriend({required String userId}) async {
    try {
      final response = await _friendRestClient.checkFriend(userId: userId);
      if (response.error == false) {
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
  Future<Either<Failure, int>> cancelFriendRequest(
      {required String userId}) async {
    try {
      final response =
          await _friendRestClient.cancelFriendRequest(userId: userId);
      if (response.error == false) {
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
  Future<Either<Failure, int>> confirmFriendRequest(
      {required String userId}) async {
    try {
      final response =
          await _friendRestClient.confirmFriendRequest(userId: userId);
      if (response.error == false) {
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
  Future<Either<Failure, int>> deleteFriend({required String userId}) async {
    try {
      final response = await _friendRestClient.deleteFriend(userId: userId);
      if (response.error == false) {
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
  Future<Either<Failure, ListUser>> getFriends() async {
    try {
      final response = await _friendRestClient.getFriends();
      if (response.error == false) {
        return Right(response.data!.toEntity());
      } else {
        String message = response.message;
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
