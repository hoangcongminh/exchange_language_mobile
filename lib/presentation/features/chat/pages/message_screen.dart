import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/search_box.dart';
import '../../conversation/bloc/conversation_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_item.dart';
import '../widgets/chat_list_shimmer.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          return CustomScrollView(
            slivers: [
              // SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 10.h,
              //     child: Center(
              //       child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemBuilder: (context, index) {
              //           return AvatarWidget(
              //             imageUrl:
              //                 'https://www.w3schools.com/howto/img_avatar.png',
              //             height: 40.sp,
              //             width: 40.sp,
              //             margin: EdgeInsets.symmetric(horizontal: 12.sp),
              //           );
              //         },
              //         itemCount: 10,
              //       ),
              //     ),
              //   ),
              // ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 8.sp),
                    SearchBox(
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 8.sp),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onLongPress: () {},
                      onTap: () {
                        AppBloc.conversationBloc.add(RefreshMessage(
                            conversationId: state.conversations[index].id));
                        AppNavigator().push(RouteConstants.conversation,
                            arguments: {
                              'conversation': state.conversations[index]
                            });
                      },
                      child: ChatItem(conversation: state.conversations[index]),
                    );
                  },
                  childCount: state.conversations.length, // 1000 list items
                ),
              ),
            ],
          );
        } else {
          return const ChatListShimmer();
        }
      },
    );
  }
}
