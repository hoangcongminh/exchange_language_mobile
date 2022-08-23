import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/data/models/notification_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/api_response_model.dart';

part 'notification_rest_client.g.dart';

@RestApi()
abstract class NotificationRestClient {
  factory NotificationRestClient(Dio dio, {String baseUrl}) =
      _NotificationRestClient;

  @GET('/notifications')
  Future<ApiResponseModel<ListNotificationModel>> getNotifications();

  @GET('/notifications/seen/{notiId}')
  Future<ApiResponseModel<ListNotificationModel>> seenNotification({
    @Path('notiId') required String notiId,
  });

  @DELETE('/notifications/{notiId}')
  Future<ApiResponseModel<ListNotificationModel>> deleteNotification({
    @Path('notiId') required String notiId,
  });
}
