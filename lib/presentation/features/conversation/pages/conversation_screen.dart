import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
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
import '../../../../domain/entities/user.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/chat_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../user-profile/bloc/user-profile-bloc/user_profile_bloc.dart';
import '../bloc/conversation_bloc.dart';
import '../widgets/conversation_input.dart';
import '../widgets/conversation_list_shimmer.dart';
import '../widgets/message_audio.dart';

class ConversationScreen extends StatefulWidget {
  final User user;
  const ConversationScreen({
    Key? key,
    required this.user,
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
    return BlocConsumer<ConversationBloc, ConversationState>(
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
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                )
              ],
              title: GestureDetector(
                onTap: () {
                  AppBloc.userProfileBloc.add(
                    GetUserProfileEvent(userId: widget.user.id),
                  );
                  AppNavigator().push(RouteConstants.userProfile);
                },
                child: Row(
                  children: [
                    AvatarWidget(
                      width: 40,
                      height: 40,
                      imageUrl: widget.user.avatar == null
                          ? null
                          : '${AppConstants.baseImageUrl}${widget.user.avatar!.src}',
                    ),
                    const SizedBox(width: 8),
                    Text(
                      state.conversation.conversationName == null
                          ? widget.user.fullname
                          : state.conversation.conversationName!,
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(
                      child: SmartRefresher(
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
                      conversationId: state.conversation.id,
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
                  )),
                  ConversationInput(
                    onSend: (content) {
                      AppBloc.conversationBloc.add(SendMessage(
                          conversationId: state.conversation.id,
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
                                    conversationId: state.conversation.id,
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
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return RecordAudioWidet(
                              onSendAudio: (recordedFile) {
                                AppBloc.conversationBloc.add(SendAudioMessage(
                                    conversationId: state.conversation.id,
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
        return Scaffold(
          appBar: AppBar(),
          body: const ConversationListShimmer(),
        );
      },
    );
  }
}
