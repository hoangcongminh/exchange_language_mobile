import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/message.dart';
import '../../../theme/chat_style.dart';
import '../../../widgets/avatar_widget.dart';

class MessageBubble extends StatefulWidget {
  final Message message;
  final bool isShowAvatar;
  const MessageBubble({
    Key? key,
    required this.message,
    this.isShowAvatar = false,
  }) : super(key: key);

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   padding: EdgeInsets.only(top: 20.sp, bottom: 12.sp),
          //   child: Text(
          //     DateFormat('dd/MM/yyyy HH:mm')
          //         .format(DateTime.parse(widget.message.createdAt)),
          //     style: TextStyle(
          //       // color: colorTimeChat,
          //       fontSize: 10.sp,
          //     ),
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.message.isMe)
                Padding(
                  padding: EdgeInsets.only(left: 40.sp, bottom: 2.sp),
                  child: Text(widget.message.author.fullname),
                ),
              Row(
                mainAxisAlignment: widget.message.isMe
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 5.sp),
                  !widget.message.isMe
                      ? AvatarWidget(
                          height: 25.sp,
                          width: 25.sp,
                          imageUrl: widget.message.author.avatar == null
                              ? null
                              : '${AppConstants.baseImageUrl}${widget.message.author.avatar!.src}',
                        )
                      : SizedBox(height: 20.sp, width: 20.sp),
                  Container(
                    margin: EdgeInsets.only(
                      right: 8.sp,
                      left: 5.sp,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: 65.w,
                    ),
                    decoration: BoxDecoration(
                      color: widget.message.isMe
                          ? colorBackgroundMessageSender
                          : colorBackgroundMessageReiceiver,
                      borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.sp, vertical: 12.sp),
                      child: Text(widget.message.content ?? ''),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
