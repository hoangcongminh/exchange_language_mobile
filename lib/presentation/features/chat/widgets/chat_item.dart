import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/conversation.dart';
import '../../../theme/chat_style.dart';
import '../../../widgets/avatar_widget.dart';

class ChatItem extends StatefulWidget {
  final Conversation conversation;
  const ChatItem({Key? key, required this.conversation}) : super(key: key);
  // const ChatItem({
  //   Key? key,
  // }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    final user = widget.conversation.members.length > 1
        ? widget.conversation.members
            .where((element) => element.id != UserLocal().getUser()!.id)
            .first
        : widget.conversation.members.first;

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
                    imageUrl: user.avatar == null
                        ? null
                        : '${AppConstants.baseImageUrl}${user.avatar!.src}',
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
                          widget.conversation.conversationName == null
                              ? user.fullname
                              : widget.conversation.conversationName!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.sp),
                        Text(
                          widget.conversation.lastMessage == null
                              ? ''
                              : '${widget.conversation.lastMessage!.author.fullname}: ${widget.conversation.lastMessage!.content ?? ''}',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(widget.conversation.modifiedAt),
                  style: TextStyle(
                    color: colorTimeChat,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  DateFormat('hh:mm a').format(widget.conversation.modifiedAt),
                  style: TextStyle(
                    color: colorTimeChat,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
