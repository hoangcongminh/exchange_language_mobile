import 'package:flutter/material.dart';

import 'notification_shimmer_item.dart';

class NotificationShimmerList extends StatelessWidget {
  const NotificationShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) => const NotificationShimmerItem(),
    );
  }
}
