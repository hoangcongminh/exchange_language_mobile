import 'package:exchange_language_mobile/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

io.Socket? socket;

void connectAndListen() {
  disconnectBeforeConnect();
  String socketUrl = AppConstants.socketUrl;
  socket = io.io(
    socketUrl,
    io.OptionBuilder().enableForceNew().setTransports(['websocket']).setAuth({
      'authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjYyMTRhNjk2NTYyODI4ZmI0OTU3OWQiLCJpYXQiOjE2NTA2MDI4NTR9.-is2QYqTN1AwTsNiofgwoDrpe_a-cyn21-bvwQAgRRs'
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
