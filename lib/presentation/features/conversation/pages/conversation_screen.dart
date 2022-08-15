import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:exchange_language_mobile/presentation/common/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/widgets/message_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/conversation.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/chat_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/custom_image_picker.dart';
import '../bloc/conversation_bloc.dart';
import '../widgets/conversation_input.dart';
import '../widgets/conversation_list_shimmer.dart';

class ConversationScreen extends StatefulWidget {
  final Conversation conversation;
  const ConversationScreen({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() {
    // AppBloc.blogBloc.add(RefreshBlogsEvent());
    _refreshController.refreshCompleted();
  }

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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: appBarColor,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        elevation: 0.5,
        centerTitle: false,
        titleSpacing: 0,
        title: GestureDetector(
          onTap: () => AppNavigator().push(
            RouteConstants.userProfile,
            arguments: {'user': widget.conversation.members.first},
          ),
          child: Row(
            children: [
              AvatarWidget(
                width: 40,
                height: 40,
                imageUrl: widget.conversation.members.first.avatar == null
                    ? null
                    : '${AppConstants.baseImageUrl}${widget.conversation.members.first.avatar!.src}',
              ),
              const SizedBox(width: 8),
              Text(widget.conversation.members.first.fullname)
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ConversationBloc, ConversationState>(
                builder: (context, state) {
                  if (state is ConversationLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      scrollToBottom();
                    });
                    return SmartRefresher(
                      header: CustomHeader(
                        builder: (context, mode) {
                          return const SizedBox(
                            height: 60.0,
                            child: SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: CupertinoActivityIndicator(),
                            ),
                          );
                        },
                      ),
                      onRefresh: _onRefresh,
                      controller: _refreshController,
                      enablePullUp: false,
                      enablePullDown: true,
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            return MessageBubble(
                                message: state.messages[index]);
                          }),
                    );
                  }
                  return const ConversationListShimmer();
                },
              ),
            ),
            ConversationInput(
              onSend: (content) {
                AppBloc.conversationBloc.add(
                    SendMessage("6285df6a453cd9b71396fd95", content.trim()));
              },
              onTapEmoji: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext subcontext) {
                    return SizedBox(
                      height: 30.h,
                      child: EmojiPicker(
                        config: const Config(
                          buttonMode: ButtonMode.CUPERTINO,
                          bgColor: colorConversationInput,
                          emojiSizeMax: 40,
                        ),
                        onEmojiSelected: (category, emoji) {
                          print(emoji.emoji);
                          AppNavigator().pop();
                        },
                      ),
                    );
                  },
                );
              },
              onTapImage: () {
                CustomImagePicker().openImagePicker(
                    context: context,
                    handleFinish: (file) {
                      print(file.toString());
                    });
              },
              onTapRecord: () {},
            ),
          ],
        ),
      ),
    );
  }
}
