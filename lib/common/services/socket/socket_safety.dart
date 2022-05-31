import 'package:flutter/material.dart';

class SocketSafety {
  static List<Map<String, dynamic>> events = [];

  // static void emit(Function fn) {
  //   if (socket == null || !socket!.connected) {
  //     QueueService.addQueue(() => fn());
  //   } else {
  //     fn();
  //   }
  // }

  static bool isNotDuplicated({required String event, dynamic data}) {
    debugPrint('$event: $data');
    Map<String, dynamic> eventData = {
      event: data,
    };

    if (events.isEmpty) {
      return true;
    }

    if (events.last != eventData) {
      events.add(eventData);
      return true;
    }

    return false;
  }
}
