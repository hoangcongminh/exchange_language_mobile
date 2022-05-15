import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../constants/app_constants.dart';

io.Socket? socket;

void connectAndListen() {
  disconnectBeforeConnect();
  String socketUrl = AppConstants.socketUrl;
  socket = io.io(
    socketUrl,
    io.OptionBuilder()
        .disableAutoConnect()
        .setTransports(['websocket']).setAuth({
      'authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjYyMTRhZjk2NTYyODI4ZmI0OTU3YTIiLCJpYXQiOjE2NTA2MDI3NzN9.lvNJd2SnHd0UMeTuDVtEr1q3wDLSO1H--eXVBnzpMX4'
    }).build(),
  );

  socket!
    ..onConnect((_) => debugPrint('Connected to socket server'))
    ..onConnecting((_) => debugPrint('onConnecting'))
    ..onConnectError((a) => debugPrint('onConnectError: $a'))
    ..onConnectTimeout((a) => debugPrint('onConnectTimeout: $a'))
    ..onDisconnect((_) => debugPrint('disconnect'));

  socket!.connect();
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
