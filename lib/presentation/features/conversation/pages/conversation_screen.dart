import 'package:exchange_language_mobile/presentation/features/conversation/widgets/conversation_input.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/widgets/conversation_list_shimmer.dart';
import 'package:exchange_language_mobile/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

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
          children: [
            Expanded(child: const ConversationListShimmer()),
            ConversationInput(),
          ],
        ),
      ),
    );
  }
}
