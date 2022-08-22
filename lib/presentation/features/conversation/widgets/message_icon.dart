import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/message.dart';
import '../../../widgets/avatar_widget.dart';

class MessageIcon extends StatelessWidget {
  final Message message;
  const MessageIcon({Key? key, required this.message}) : super(key: key);

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
              if (!message.isMe)
                Padding(
                  padding: EdgeInsets.only(left: 40.sp, bottom: 2.sp),
                  child: Text(message.author.fullname),
                ),
              Row(
                mainAxisAlignment: message.isMe
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
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
                  Container(
                    margin: EdgeInsets.only(
                      right: 8.sp,
                      left: 5.sp,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.sp),
                    child: Text(
                      message.content ?? '',
                      style: const TextStyle(fontSize: 80),
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
