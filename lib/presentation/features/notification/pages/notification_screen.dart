import 'package:exchange_language_mobile/presentation/features/notification/widgets/notification_item.dart';
import 'package:exchange_language_mobile/presentation/features/notification/widgets/notification_shimmer_list.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      // body: const NotificationShimmerList(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return NotificationItem();
        },
      ),
    );
  }
}
