import 'package:exchange_language_mobile/presentation/features/notification/widgets/notification_shimmer_item.dart';
import 'package:flutter/material.dart';

class NotificationShimmerList extends StatelessWidget {
  const NotificationShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) => const NotificationShimmerItem(),
    );
  }
}
