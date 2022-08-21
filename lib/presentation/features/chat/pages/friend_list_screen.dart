import 'package:exchange_language_mobile/presentation/features/chat/widgets/chat_list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../widgets/avatar_widget.dart';
import '../bloc/friend-list/friend_list_bloc.dart';

class FriendListScreen extends StatelessWidget {
  const FriendListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendListBloc, FriendListState>(
      builder: (context, state) {
        if (state is FriendListLoaded) {
          return ListView.builder(
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
                      // Icon(
                      //   Icons.chat_bubble,
                      //   size: 20.sp,
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const ChatListShimmer();
        }
      },
    );
  }
}
