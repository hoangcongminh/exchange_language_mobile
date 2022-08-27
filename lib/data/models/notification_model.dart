import 'package:exchange_language_mobile/data/models/user_model.dart';
import 'package:exchange_language_mobile/domain/entities/notification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'userSender')
  final UserModel? userSender;
  @JsonKey(name: 'userReceiver')
  final UserModel? userReceiver;
  @JsonKey(name: 'type')
  final int type;
  @JsonKey(name: 'dataTarget')
  final String? dataTarget;
  @JsonKey(name: 'status')
  final int status;
  @JsonKey(name: 'createdAt')
  final String createdAt;

  NotificationModel(
    this.id,
    this.userSender,
    this.userReceiver,
    this.type,
    this.dataTarget,
    this.status,
    this.createdAt,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  Notificaton toEntity() => Notificaton(
        id: id,
        type: type,
        userSender: userSender?.toEntity(),
        userReceiver: userReceiver?.toEntity(),
        dataTarget: dataTarget,
        status: status,
        createdAt: createdAt,
      );
}

@JsonSerializable(explicitToJson: true)
class ListNotificationModel {
  @JsonKey(name: 'data')
  final List<NotificationModel> data;
  @JsonKey(name: 'total')
  final int total;

  const ListNotificationModel(
    this.data,
    this.total,
  );

  factory ListNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ListNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListNotificationModelToJson(this);

  ListNotificaton toEntity() => ListNotificaton(
        notifications: data.map((e) => e.toEntity()).toList(),
        total: total,
      );
}

@JsonSerializable(explicitToJson: true)
class SocketNotificationModel {
  @JsonKey(name: 'infoNoti')
  final NotificationModel infoNoti;

  const SocketNotificationModel(
    this.infoNoti,
  );

  factory SocketNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$SocketNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocketNotificationModelToJson(this);
}
