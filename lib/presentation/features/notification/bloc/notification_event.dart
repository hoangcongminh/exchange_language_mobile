part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotificaton extends NotificationEvent {}

class SeenNotification extends NotificationEvent {
  final String notificationId;
  const SeenNotification({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}

class DeleteNotification extends NotificationEvent {
  final String notificationId;
  const DeleteNotification({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}
