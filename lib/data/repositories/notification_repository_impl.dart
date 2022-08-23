import 'package:dartz/dartz.dart';
import 'package:exchange_language_mobile/data/datasources/remote/notification_rest_client.dart';
import 'package:exchange_language_mobile/domain/entities/notification.dart';
import 'package:exchange_language_mobile/domain/repository/notification_repository.dart';

import '../datasources/remote/app_api_service.dart';
import '../failure.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRestClient _notificationRestClient =
      AppApiService().notificatonRestClient;

  @override
  Future<Either<Failure, ListNotificaton>> getNotifications() async {
    try {
      final response = await _notificationRestClient.getNotifications();

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

  @override
  Future<Either<Failure, ListNotificaton>> seenNotification(
      {required String notificationId}) async {
    try {
      final response = await _notificationRestClient.seenNotification(
          notiId: notificationId);

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

  @override
  Future<Either<Failure, ListNotificaton>> deleteNotification(
      {required String notificationId}) async {
    try {
      final response = await _notificationRestClient.deleteNotification(
          notiId: notificationId);

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
