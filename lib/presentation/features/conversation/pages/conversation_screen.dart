import 'package:flutter/material.dart';

import '../widgets/conversation_input.dart';
import '../widgets/conversation_list_shimmer.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleTextStyle: Theme.of(context).textTheme.headline6,
        centerTitle: false,
        title: const Text('Jenny Huỳnh'),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: const [
            Expanded(child: ConversationListShimmer()),
            ConversationInput(),
          ],
        ),
      ),
    );
  }
}
