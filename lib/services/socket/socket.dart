import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../common/constants/app_constants.dart';

IO.Socket? socket;

void connectAndListen() {
  disconnectBeforeConnect();
  String socketUrl = AppConstants.socketUrl;
  socket = IO.io(socketUrl);

  socket!.connect();

  socket!.onConnect((_) {
    debugPrint('Connected to socket server');
  });

  socket!.onDisconnect((_) => debugPrint('disconnect'));
}

void disconnectBeforeConnect() {
  if (socket != null) {
    if (socket!.connected) {
      socket!.disconnect();
      socket = null;
    }
  }
}

bool isSocketConnected() {
  return socket != null && socket!.connected;
}
