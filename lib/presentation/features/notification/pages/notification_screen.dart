import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../widgets/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notification),
      ),
      // body: const NotificationShimmerList(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const NotificationItem();
        },
      ),
    );
  }
}
