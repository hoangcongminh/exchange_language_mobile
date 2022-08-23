import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../data/datasources/local/user_local_data.dart';
import '../../../data/models/message_model.dart';
import '../../../presentation/common/app_bloc.dart';
import '../../../presentation/features/conversation/bloc/conversation_bloc.dart';
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
        if (state.conversationId == message.conversationId) {
          return;
        }
      }
      showOverlayNotification(
        (context) {
          return GestureDetector(
            onTap: () {
              AppBloc.conversationBloc
                  .add(RefreshMessage(conversationId: message.conversationId));
              AppNavigator().push(RouteConstants.conversation, arguments: {
                'user': message.author,
              });
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

  socket!.on(SocketEvents.notification, (data) {
    if (SocketSafety.isNotDuplicated(
        event: SocketEvents.receiveMessage, data: data)) {
      print(data);
    }
  });
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
