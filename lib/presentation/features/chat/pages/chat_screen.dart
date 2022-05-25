import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/search_box.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_item.dart';
import '../widgets/chat_list_shimmer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chat),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10.h,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return AvatarWidget(
                      imageUrl:
                          'https://www.w3schools.com/howto/img_avatar.png',
                      height: 40.sp,
                      width: 40.sp,
                      margin: EdgeInsets.symmetric(horizontal: 12.sp),
                    );
                  },
                  itemCount: 10,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 8.sp),
                const SearchBox(),
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
                    AppNavigator().push(
                      RouteConstants.conversation,
                    );
                  },
                  child: const ChatItem(),
                );
              },
              childCount: 10, // 1000 list items
            ),
          ),
        ],
      ),
      // body: Column(
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     SizedBox(height: 12.sp),
      //     SizedBox(
      //       height: 10.h,
      //       child: ListView.builder(
      //         scrollDirection: Axis.horizontal,
      //         itemBuilder: (context, index) {
      //           return AvatarWidget(
      //             imageUrl: 'https://www.w3schools.com/howto/img_avatar.png',
      //             height: 40.sp,
      //             width: 40.sp,
      //             margin: EdgeInsets.symmetric(horizontal: 12.sp),
      //           );
      //         },
      //         itemCount: 10,
      //       ),
      //     ),
      //     SizedBox(height: 8.sp),
      //     const SearchBox(),
      //     SizedBox(height: 8.sp),
      //     Expanded(
      //       child: BlocBuilder<ChatBloc, ChatState>(
      //         builder: (context, state) {
      //           if (state is ConversationLoading) {
      //             return const ChatListShimmer();
      //           }
      //           return ListView.builder(
      //             itemCount: 10,
      //             itemBuilder: (context, index) {
      //               return GestureDetector(
      //                 onLongPress: () {},
      //                 onTap: () {
      //                   AppNavigator().push(
      //                     RouteConstants.conversation,
      //                   );
      //                 },
      //                 child: const ChatItem(),
      //               );
      //             },
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
