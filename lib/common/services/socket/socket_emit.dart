import 'package:exchange_language_mobile/common/services/socket/socket.dart';

import '../../constants/socket_events.dart';

class SocketEmit {
  sendMessage(
      {required String conversationId,
      required String content,
      required int type}) {
    socket!.emit(SocketEvents.sendMessage, {
      '_idConversation': conversationId,
      'content': content,
      'type': type,
    });
  }
}
