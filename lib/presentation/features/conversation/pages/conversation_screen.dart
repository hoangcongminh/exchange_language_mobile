import 'package:exchange_language_mobile/presentation/common/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/chat_style.dart';
import '../../../widgets/custom_image_picker.dart';
import '../bloc/conversation_bloc.dart';
import '../widgets/conversation_input.dart';
import '../widgets/conversation_list_shimmer.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final ScrollController _scrollController = ScrollController();

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: appBarColor,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        elevation: 0.5,
        centerTitle: false,
        title: const Text('Jenny Huỳnh'),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ConversationBloc, ConversationState>(
                builder: (context, state) {
                  if (state is ConversationLoaded) {
                    return ListView.builder(
                        controller: _scrollController,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          return MessageBubble(message: state.messages[index]);
                        });
                  }
                  return const ConversationListShimmer();
                },
              ),
            ),
            ConversationInput(
              onSend: (content) {
                AppBloc.conversationBloc
                    .add(SendMessage("6285df6a453cd9b71396fd95", content));
              },
              onTapImage: () {
                CustomImagePicker().openImagePicker(
                    context: context,
                    handleFinish: (file) {
                      print(file.toString());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
