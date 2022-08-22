import 'package:exchange_language_mobile/presentation/features/chat/widgets/chat_list_shimmer.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/bloc/conversation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/chat_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../bloc/friend-list/friend_list_bloc.dart';

class FriendListScreen extends StatelessWidget {
  FriendListScreen({
    Key? key,
  }) : super(key: key);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() {
    AppBloc.friendListBloc.add(FetchFriendList());
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
    return BlocBuilder<FriendListBloc, FriendListState>(
      builder: (context, state) {
        if (state is FriendListLoaded) {
          return SmartRefresher(
            header: const WaterDropHeader(),
            onRefresh: _onRefresh,
            controller: _refreshController,
            // onLoading: _onLoading,
            // enablePullUp: true,
            child: ListView.builder(
              itemCount: state.friends.length,
              itemBuilder: (context, index) {
                final friend = state.friends[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.sp),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              AvatarWidget(
                                imageUrl: friend.avatar == null
                                    ? null
                                    : '${AppConstants.baseImageUrl}${friend.avatar!.src}',
                                width: 40.sp,
                                height: 40.sp,
                              ),
                              SizedBox(width: 12.sp),
                              Expanded(
                                child: Text(
                                  friend.fullname,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        IconButton(
                          onPressed: () {
                            AppBloc.conversationBloc
                                .add(CreateOrGetMessage(userId: friend.id));
                            AppNavigator()
                                .push(RouteConstants.conversation, arguments: {
                              'user': friend,
                            });
                          },
                          icon: Icon(
                            Icons.chat_outlined,
                            size: 20.sp,
                            color: colorTimeChat,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const ChatListShimmer();
        }
      },
    );
  }
}
