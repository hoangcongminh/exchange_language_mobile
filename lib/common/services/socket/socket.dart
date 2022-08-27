import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/data/models/notification_model.dart';
import 'package:exchange_language_mobile/data/repositories/post_repository_impl.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../data/datasources/local/user_local_data.dart';
import '../../../data/models/message_model.dart';
import '../../../presentation/common/app_bloc.dart';
import '../../../presentation/features/comment/bloc/comment_bloc.dart';
import '../../../presentation/features/conversation/bloc/conversation_bloc.dart';
import '../../../presentation/features/user-profile/bloc/user-profile-bloc/user_profile_bloc.dart';
import '../../../presentation/widgets/avatar_widget.dart';
import '../../constants/app_constants.dart';
import '../../constants/socket_events.dart';
import 'socket_safety.dart';

io.Socket? socket;

void connectAndListen() {
  disconnectBeforeConnect();
  String socketUrl = AppConstants.socketUrl;
  final String token = UserLocal().getAccessToken();
  socket = io.io(
      socketUrl,
      io.OptionBuilder()
          // .disableAutoConnect(
          .enableForceNew()
          .setTransports(['websocket']).setExtraHeaders(
              {'authorization': 'Bearer $token'}).build());

  socket!.connect();
  socket!
    ..onConnect((_) => debugPrint('Connected to socket server'))
    ..onConnectError((a) => debugPrint('onConnectError: $a'))
    ..onConnecting((_) => debugPrint('Connecting to server'))
    ..onConnectTimeout((a) => debugPrint('onConnectTimeout: $a'))
    ..onError((a) => debugPrint('onError: $a'))
    ..onDisconnect((_) => debugPrint('disconnect'));

  socket!.on(SocketEvents.receiveMessage, (data) {
    if (SocketSafety.isNotDuplicated(
        event: SocketEvents.receiveMessage, data: data)) {
      final message = MessageItemModel.fromJson(data).toEntity();
      AppBloc.conversationBloc.add(
        ReceiveNewMessage(
          MessageItemModel.fromJson(data).toEntity(),
        ),
      );
      if (AppBloc.conversationBloc.state is ConversationLoaded &&
          AppNavigator().currentRoute() == RouteConstants.conversation) {
        final state = AppBloc.conversationBloc.state as ConversationLoaded;
        if (state.conversation.id == message.conversationId) {
          return;
        }
      }
      showOverlayNotification(
        (context) {
          return GestureDetector(
            onTap: () {
              AppBloc.conversationBloc
                  .add(RefreshMessage(conversationId: message.conversationId));
              AppNavigator().push(RouteConstants.conversation);
            },
            child: Container(
              color: Colors.transparent,
              child: SafeArea(
                top: true,
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: ListTile(
                    leading: AvatarWidget(
                      imageUrl: message.author.avatar == null
                          ? null
                          : '${AppConstants.baseImageUrl}${message.author.avatar!.src}',
                      width: 40,
                      height: 40,
                    ),
                    title: Text(message.author.fullname),
                    subtitle: Text(
                      message.type == 1
                          ? 'Send you a voice message'
                          : message.content ?? '',
                    ),
                    trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          OverlaySupportEntry.of(context)?.dismiss();
                        }),
                  ),
                ),
              ),
            ),
          );
        },
        duration: const Duration(milliseconds: 4000),
      );
    }
  });

  socket!.on(SocketEvents.notification, (data) async {
    if (SocketSafety.isNotDuplicated(
        event: SocketEvents.receiveMessage, data: data)) {
      final notification =
          SocketNotificationModel.fromJson(data).infoNoti.toEntity();
      switch (notification.type) {
        // SYSTEM : 0,
        // SEND_REQUEST_FRIEND : 1,
        // ACCEPT_REQUEST_FRIEND : 2,
        // FAVORITE_POST : 3,
        // COMMENT_POST : 4,
        // JOIN_GROUP : 5,
        // RATING: 6
        case 0:
          return;
        case 1:
          notify(
            onTap: () {
              AppBloc.userProfileBloc
                  .add(GetUserProfileEvent(userId: notification.dataTarget!));
              AppNavigator().push(RouteConstants.userProfile);
            },
            avatar: notification.userSender?.avatar,
            title:
                '${notification.userSender!.fullname} sent you a friend request',
          );
          return;
        case 2:
          notify(
            onTap: () {
              AppBloc.userProfileBloc
                  .add(GetUserProfileEvent(userId: notification.dataTarget!));
              AppNavigator().push(RouteConstants.userProfile);
            },
            avatar: notification.userSender?.avatar,
            title:
                '${notification.userSender!.fullname} accepted your friend request',
          );
          return;
        case 3:
          await PostRepositoryImpl()
              .getPostDetail(
                postId: notification.dataTarget!,
              )
              .then((value) => value.fold((failure) {
                    return null;
                  }, (post) {
                    notify(
                      onTap: () {
                        AppBloc.commentBloc
                            .add(FetchCommentEvent(postId: post.id));
                        AppNavigator().push(RouteConstants.comment,
                            arguments: {'post': post});
                      },
                      avatar: notification.userSender?.avatar,
                      title:
                          '${notification.userSender!.fullname} liked your post',
                    );
                  }));
          return;
        case 4:
          await PostRepositoryImpl()
              .getPostDetail(
                postId: notification.dataTarget!,
              )
              .then((value) => value.fold((failure) {
                    return null;
                  }, (post) {
                    notify(
                      onTap: () {
                        AppBloc.commentBloc
                            .add(FetchCommentEvent(postId: post.id));
                        AppNavigator().push(RouteConstants.comment,
                            arguments: {'post': post});
                      },
                      avatar: notification.userSender?.avatar,
                      title:
                          '${notification.userSender?.fullname} commented on your post',
                    );
                  }));
          return;
        case 5:
          notify(
            onTap: () {},
            avatar: notification.userSender?.avatar,
            title:
                '${notification.userSender!.fullname} has joined ${notification.dataTarget}',
          );
          return;
        case 6:
          notify(
            onTap: () {},
            avatar: notification.userSender?.avatar,
            title:
                '${notification.userSender!.fullname} rated you ${notification.dataTarget}',
          );
          return;
      }
    }
  });
}

void notify({
  required VoidCallback onTap,
  Avatar? avatar,
  required String title,
  String? subTitle,
}) {
  showOverlayNotification(
    (context) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: SafeArea(
            top: true,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: ListTile(
                leading: AvatarWidget(
                  imageUrl: avatar == null
                      ? null
                      : '${AppConstants.baseImageUrl}${avatar.src}',
                  width: 40,
                  height: 40,
                ),
                title: Text(title),
                subtitle: subTitle == null ? null : Text(subTitle),
                trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context)?.dismiss();
                    }),
              ),
            ),
          ),
        ),
      );
    },
    duration: const Duration(milliseconds: 4000),
  );
}

void disconnectBeforeConnect() {
  // if (socket != null) {
  //   if (socket!.connected) {
  //     socket!.disconnect();
  //     socket!.close();
  //     socket = null;
  //   }
  // }
  if (isSocketConnected()) {
    socket!.disconnect();
    socket!.close();
    socket = null;
  }
}

bool isSocketConnected() {
  return socket != null && socket!.connected;
}
