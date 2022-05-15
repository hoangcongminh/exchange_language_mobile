import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/chat_style.dart';
import '../../../widgets/avatar_widget.dart';

class ChatItem extends StatefulWidget {
  // final Conversation conversation;
  // const ChatItem({Key? key, required this.conversation}) : super(key: key);
  const ChatItem({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      AvatarWidget(
                        // imageUrl:
                        //     'https://www.w3schools.com/howto/img_avatar.png',
                        width: 40.sp,
                        height: 40.sp,
                      ),
                      SizedBox(width: 12.sp),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              // widget.conversation.conversationName,
                              'test 1',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4.sp),
                            Text(
                              'last message',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10.sp),
                Text(
                  // DateFormat('hh:mm a').format(widget.conversationModel.latestMessage.createdAt),
                  '12:00 PM',
                  style: TextStyle(
                    color: colorTimeChat,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
