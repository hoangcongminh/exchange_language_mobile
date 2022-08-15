import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../data/datasources/local/user_local_data.dart';
import '../../../data/models/message_model.dart';
import '../../../presentation/common/app_bloc.dart';
import '../../../presentation/features/conversation/bloc/conversation_bloc.dart';
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
      AppBloc.conversationBloc.add(
        ReceiveNewMessage(
          MessageItemModel.fromJson(data).toEntity(),
        ),
      );
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
