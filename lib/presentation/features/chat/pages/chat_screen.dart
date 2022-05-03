import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/domain/entities/conversation.dart';
import 'package:exchange_language_mobile/presentation/features/chat/bloc/chat_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/chat/widgets/chat_item.dart';
import 'package:exchange_language_mobile/presentation/features/chat/widgets/chat_list_shimmer.dart';
import 'package:exchange_language_mobile/presentation/features/chat/widgets/search_box.dart';
import 'package:exchange_language_mobile/presentation/widgets/avatar_widget.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 12.sp),
          Container(
            height: 10.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return AvatarWidget(
                  imageUrl: 'https://www.w3schools.com/howto/img_avatar.png',
                  height: 40.sp,
                  width: 40.sp,
                  margin: EdgeInsets.symmetric(horizontal: 12.sp),
                );
              },
              itemCount: 10,
            ),
          ),
          SizedBox(height: 8.sp),
          const SearchBox(),
          SizedBox(height: 8.sp),
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is Conversation) {
                  return const ChatListShimmer();
                }
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
