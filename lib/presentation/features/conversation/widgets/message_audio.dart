import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/message.dart';
import '../../../widgets/avatar_widget.dart';

class MessageAudio extends StatelessWidget {
  final Message message;

  const MessageAudio({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe)
            Padding(
              padding: EdgeInsets.only(left: 40.sp, bottom: 2.sp),
              child: Text(message.author.fullname),
            ),
          Row(
            mainAxisAlignment:
                message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5.sp),
              !message.isMe
                  ? AvatarWidget(
                      height: 25.sp,
                      width: 25.sp,
                      imageUrl: message.author.avatar == null
                          ? null
                          : '${AppConstants.baseImageUrl}${message.author.avatar!.src}',
                    )
                  : SizedBox(height: 20.sp, width: 20.sp),
              VoiceMessage(
                audioSrc: 'https://sounds-mp3.com/mp3/0012660.mp3',
                played: false, // To show played badge or not.
                me: false, // Set message side.
                onPlay: () {}, // Do something when voice played.
              ),
            ],
          ),
        ],
      ),
    );
  }
}
