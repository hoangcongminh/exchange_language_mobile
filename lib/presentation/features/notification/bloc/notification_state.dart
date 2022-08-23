part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<Notificaton> notifications;
  const NotificationLoaded({required this.notifications});

  @override
  List<Object> get props => [notifications];
}

class NotificationLoading extends NotificationState {}

class NotificationLoadFailure extends NotificationState {
  final String message;
  const NotificationLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
