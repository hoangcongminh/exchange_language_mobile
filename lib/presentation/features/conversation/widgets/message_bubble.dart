import 'package:exchange_language_mobile/common/helpers/translation_helper.dart';
import 'package:exchange_language_mobile/presentation/widgets/text_tap.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/message.dart';
import '../../../theme/chat_style.dart';
import '../../../widgets/avatar_widget.dart';

class MessageBubble extends StatefulWidget {
  final Message message;
  const MessageBubble({
    Key? key,
    required this.message,
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
          // if (DateTime.now().day != widget.message.createdAt.day)
          //   Container(
          //     padding: EdgeInsets.only(top: 20.sp, bottom: 12.sp),
          //     child: Text(
          //       DateFormat('dd/MM/yyyy HH:mm').format(widget.message.createdAt),
          //       style: TextStyle(
          //         // color: colorTimeChat,
          //         fontSize: 10.sp,
          //       ),
          //     ),
          //   ),
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
                      // right: 8.sp,
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
                      child: TextTap(
                        text: widget.message.content ?? '',
                        selectText: (text) =>
                            TranslationHelper().showTranslate(context, text),
                      ),
                    ),
                  ),
                  if (!widget.message.isMe)
                    IconButton(
                      onPressed: () => TranslationHelper()
                          .showTranslate(context, widget.message.content),
                      icon: const Icon(Icons.translate),
                    )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
