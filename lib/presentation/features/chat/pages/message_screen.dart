import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../conversation/bloc/conversation_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_item.dart';
import '../widgets/chat_list_shimmer.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({
    Key? key,
  }) : super(key: key);

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() {
    AppBloc.chatBloc.add(FetchConversations());
    _refreshController.resetNoData();
    _refreshController.refreshCompleted();
  }

  // void _onLoading() async {
  //   AppBloc.groupBloc.add(FetchGroupsEvent());
  //   if (AppBloc.groupBloc.total == AppBloc.groupBloc.groups.length) {
  //     _refreshController.loadNoData();
  //   } else {
  //     _refreshController.loadComplete();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          return SmartRefresher(
            header: const WaterDropHeader(),
            onRefresh: _onRefresh,
            controller: _refreshController,
            // onLoading: _onLoading,
            // enablePullUp: true,
            child: ListView.builder(
              itemCount: state.conversations.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {},
                  onTap: () {
                    AppBloc.conversationBloc.add(RefreshMessage(
                        conversationId: state.conversations[index].id));
                    AppNavigator()
                        .push(RouteConstants.conversation, arguments: {
                      'user': state.conversations[index].members
                          .where((element) =>
                              element.id != UserLocal().getUser()!.id)
                          .first,
                    });
                  },
                  child: ChatItem(conversation: state.conversations[index]),
                );
              },
            ),
          );
          // return CustomScrollView(
          //   slivers: [
          //     // SliverToBoxAdapter(
          //     //   child: SizedBox(
          //     //     height: 10.h,
          //     //     child: Center(
          //     //       child: ListView.builder(
          //     //         scrollDirection: Axis.horizontal,
          //     //         itemBuilder: (context, index) {
          //     //           return AvatarWidget(
          //     //             imageUrl:
          //     //                 'https://www.w3schools.com/howto/img_avatar.png',
          //     //             height: 40.sp,
          //     //             width: 40.sp,
          //     //             margin: EdgeInsets.symmetric(horizontal: 12.sp),
          //     //           );
          //     //         },
          //     //         itemCount: 10,
          //     //       ),
          //     //     ),
          //     //   ),
          //     // ),
          //     // SliverToBoxAdapter(
          //     //   child: Column(
          //     //     children: [
          //     //       SizedBox(height: 8.sp),
          //     //       SearchBox(
          //     //         onChanged: (text) {},
          //     //       ),
          //     //       SizedBox(height: 8.sp),
          //     //     ],
          //     //   ),
          //     // ),
          //     SliverList(
          //       delegate: SliverChildBuilderDelegate(
          //         (context, index) {
          //           return GestureDetector(
          //             onLongPress: () {},
          //             onTap: () {
          //               AppBloc.conversationBloc.add(RefreshMessage(
          //                   conversationId: state.conversations[index].id));
          //               AppNavigator()
          //                   .push(RouteConstants.conversation, arguments: {
          //                 'user': state.conversations[index].members
          //                     .where((element) =>
          //                         element.id != UserLocal().getUser()!.id)
          //                     .first,
          //               });
          //             },
          //             child: ChatItem(conversation: state.conversations[index]),
          //           );
          //         },
          //         childCount: state.conversations.length, // 1000 list items
          //       ),
          //     ),
          //   ],
          // );
        } else {
          return const ChatListShimmer();
        }
      },
    );
  }
}
