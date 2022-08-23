import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/domain/repository/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/notification.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(this._notificationRepository)
      : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) {});
    on<FetchNotificaton>(_fetchNotificaton);
    on<SeenNotification>(_seenNotification);
    on<DeleteNotification>(_deleteNotification);
  }
  Future<void> _fetchNotificaton(
      FetchNotificaton event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    await _notificationRepository.getNotifications().then((result) {
      result.fold((failure) {
        emit(NotificationLoadFailure(message: failure.message));
      }, (listNotification) {
        notifications = listNotification.notifications;
        emit(NotificationLoaded(notifications: notifications));
      });
    });
  }

  Future<void> _seenNotification(
      SeenNotification event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    await _notificationRepository
        .seenNotification(notificationId: event.notificationId)
        .then((result) {
      result.fold((failure) {
        emit(NotificationLoadFailure(message: failure.message));
      }, (listNotification) {
        notifications = listNotification.notifications;
        emit(NotificationLoaded(notifications: notifications));
      });
    });
  }

  Future<void> _deleteNotification(
      DeleteNotification event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    await _notificationRepository
        .deleteNotification(notificationId: event.notificationId)
        .then((result) {
      result.fold((failure) {
        emit(NotificationLoadFailure(message: failure.message));
      }, (listNotification) {
        notifications = listNotification.notifications;
        emit(NotificationLoaded(notifications: notifications));
      });
    });
  }

  final NotificationRepository _notificationRepository;
  List<Notificaton> notifications = [];
}
