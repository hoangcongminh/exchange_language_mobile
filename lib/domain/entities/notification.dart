import 'package:equatable/equatable.dart';

import 'user.dart';

class Notificaton extends Equatable {
  final String id;
  final User? userSender;
  final User? userReceiver;
  final int type;
  final String? dataTarget;
  final int status;
  final String createdAt;

  const Notificaton({
    required this.id,
    this.userSender,
    this.userReceiver,
    required this.type,
    this.dataTarget,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userSender,
        userReceiver,
        type,
        dataTarget,
        status,
        createdAt,
      ];
}

class ListNotificaton extends Equatable {
  final List<Notificaton> notifications;
  final int total;

  const ListNotificaton({
    required this.notifications,
    required this.total,
  });

  @override
  List<Object?> get props => [
        notifications,
        total,
      ];
}
