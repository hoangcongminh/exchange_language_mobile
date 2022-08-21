import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:exchange_language_mobile/presentation/common/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/widgets/message_bubble.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/widgets/message_icon.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/widgets/record_audio_widget.dart';
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
import '../../user-profile/bloc/user-profile-bloc/user_profile_bloc.dart';
import '../bloc/conversation_bloc.dart';
import '../widgets/conversation_input.dart';
import '../widgets/conversation_list_shimmer.dart';
import '../widgets/message_audio.dart';

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

  void _onRefresh({required String conversationId, int? skip}) {
    AppBloc.conversationBloc
        .add(FetchMessage(conversationId: conversationId, skip: skip));
    _refreshController.refreshCompleted();
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  String audioFile = '';

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
          onTap: () {
            AppBloc.userProfileBloc.add(
              GetUserProfileEvent(
                  userId: widget.conversation.members
                      .where(
                          (element) => element.id != UserLocal().getUser()?.id)
                      .first
                      .id),
            );
            AppNavigator().push(RouteConstants.userProfile);
          },
          child: Row(
            children: [
              AvatarWidget(
                width: 40,
                height: 40,
                imageUrl: widget.conversation.members
                            .where((element) =>
                                element.id != UserLocal().getUser()!.id)
                            .first
                            .avatar ==
                        null
                    ? null
                    : '${AppConstants.baseImageUrl}${widget.conversation.members.where((element) => element.id != UserLocal().getUser()!.id).first.avatar!.src}',
              ),
              const SizedBox(width: 8),
              Text(widget.conversation.members
                  .where((element) => element.id != UserLocal().getUser()!.id)
                  .first
                  .fullname)
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ConversationBloc, ConversationState>(
                listener: (context, state) {
                  if (state is ConversationLoaded) {
                    if (state.isScroll) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        scrollToBottom();
                      });
                    }
                  }
                },
                builder: (context, state) {
                  if (state is ConversationLoaded) {
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
                      onRefresh: () => _onRefresh(
                        conversationId: widget.conversation.id,
                        skip: state.messages.length,
                      ),
                      controller: _refreshController,
                      enablePullUp: false,
                      enablePullDown: true,
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            final message = state.messages[index];
                            if (message.type == 1) {
                              return MessageAudio(message: message);
                            } else if (message.type == 2) {
                              return MessageIcon(message: message);
                            } else {
                              return MessageBubble(message: message);
                            }
                          }),
                    );
                  }
                  return const ConversationListShimmer();
                },
              ),
            ),
            ConversationInput(
              onSend: (content) {
                AppBloc.conversationBloc.add(SendMessage(
                    conversationId: widget.conversation.id,
                    content: content.trim()));
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
                          AppBloc.conversationBloc.add(SendIconMessage(
                              conversationId: widget.conversation.id,
                              content: emoji.emoji.trim()));
                          AppNavigator().pop();
                        },
                      ),
                    );
                  },
                );
              },
              // onTapImage: () {
              //   CustomImagePicker().openImagePicker(
              //       context: context,
              //       handleFinish: (file) {
              //         print(file.toString());
              //       });
              // },
              onTapRecord: () {
                // AudioHelper().recordAudio(widget.conversation.id);
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return RecordAudioWidet(
                        onSendAudio: (recordedFile) {
                          AppBloc.conversationBloc.add(SendAudioMessage(
                              conversationId: widget.conversation.id,
                              audio: recordedFile));
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
