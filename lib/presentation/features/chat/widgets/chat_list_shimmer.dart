import 'package:exchange_language_mobile/presentation/features/chat/widgets/chat_shimmer_item.dart';
import 'package:flutter/material.dart';

class ChatListShimmer extends StatelessWidget {
  const ChatListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const ChatShimmerItem();
      },
    );
  }
}
