import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, ListNotificaton>> getNotifications();

  Future<Either<Failure, ListNotificaton>> seenNotification({
    required String notificationId,
  });

  Future<Either<Failure, ListNotificaton>> deleteNotification({
    required String notificationId,
  });
}
