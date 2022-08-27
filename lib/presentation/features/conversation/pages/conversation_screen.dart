import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';
import 'package:exchange_language_mobile/presentation/common/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/widgets/message_bubble.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/widgets/message_icon.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/widgets/record_audio_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/conversation.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/chat_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../chat/bloc/chat_bloc.dart';
import '../../chat/bloc/friend-list/friend_list_bloc.dart';
import '../../user-profile/bloc/user-profile-bloc/user_profile_bloc.dart';
import '../bloc/conversation_bloc.dart';
import '../widgets/conversation_input.dart';
import '../widgets/conversation_list_shimmer.dart';
import '../widgets/message_audio.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    Key? key,
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

  void _onTapMoreVert(BuildContext context, Conversation conversation) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150.sp,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.sp),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            automaticallyImplyLeading: false,
                            leading: IconButton(
                              onPressed: () {
                                AppNavigator().pop();
                              },
                              icon:
                                  const Icon(Icons.close, color: Colors.black),
                            ),
                            title: Text(
                              context.l10n.addMember,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          body: BlocBuilder<FriendListBloc, FriendListState>(
                            builder: (context, state) {
                              if (state is FriendListLoaded) {
                                return ListView.builder(
                                  itemCount: state.friends.length,
                                  itemBuilder: (context, index) {
                                    final friend = state.friends[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: AvatarWidget(
                                              shape: BoxShape.circle,
                                              height: 35.sp,
                                              width: 35.sp,
                                              imageUrl:
                                                  '${AppConstants.baseImageUrl}${friend.avatar!.src}'),
                                          title: Text(
                                            friend.fullname,
                                          ),
                                          trailing: conversation.members
                                                  .map((e) => e.id)
                                                  .contains(friend.id)
                                              ? const Icon(Icons.check)
                                              : IconButton(
                                                  onPressed: () {
                                                    AppBloc.conversationBloc
                                                        .add(InviteUser(
                                                      conversationId:
                                                          conversation.id,
                                                      userId: friend.id,
                                                    ));
                                                    AppBloc.conversationBloc
                                                        .add(FetchMessage(
                                                            conversationId:
                                                                conversation
                                                                    .id));
                                                    AppNavigator().pop();
                                                  },
                                                  icon: const Icon(Icons.add)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 50.sp),
                                          child: Divider(thickness: 1.sp),
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: Row(
                      children: [
                        const Icon(Icons.person_add),
                        SizedBox(width: 12.sp),
                        Text(
                          context.l10n.invite,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AppBloc.conversationBloc.add(
                        LeaveConversation(conversationId: conversation.id));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: Row(
                      children: [
                        const Icon(Icons.close),
                        SizedBox(width: 12.sp),
                        Text(
                          context.l10n.leaveGroup,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: const Color(0xFFC5D0CF),
                  thickness: 0.3.sp,
                  height: 0.3.sp,
                ),
              ],
            ),
          ),
        );
      },
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
        if (state is ConversationLeaveSuccess) {
          AppBloc.chatBloc.add(FetchConversations());
          AppNavigator().pushNamedAndRemoveUntil(RouteConstants.home);
        }
      },
      builder: (context, state) {
        if (state is ConversationLoaded) {
          User user;
          if (state.conversation.members.length < 2) {
            user = UserLocal().getUser()!;
          } else {
            user = state.conversation.members.firstWhere(
              (user) => user.id != UserLocal().getUser()!.id,
            );
          }

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
                if (state.conversation.members.length > 2)
                  IconButton(
                    onPressed: () =>
                        _onTapMoreVert(context, state.conversation),
                    icon: const Icon(Icons.more_vert),
                  )
              ],
              title: GestureDetector(
                onTap: state.conversation.members.length > 2
                    ? () {}
                    : () {
                        AppBloc.userProfileBloc.add(
                          GetUserProfileEvent(userId: user.id),
                        );
                        AppNavigator().push(RouteConstants.userProfile);
                      },
                child: Row(
                  children: [
                    AvatarWidget(
                      width: 40,
                      height: 40,
                      imageUrl: state.conversation.members.length > 2
                          ? '${AppConstants.baseImageUrl}${state.conversation.avatar?.src}'
                          : '${AppConstants.baseImageUrl}${user.avatar!.src}',
                    ),
                    const SizedBox(width: 8),
                    Text(
                      state.conversation.conversationName == null
                          ? user.fullname
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
