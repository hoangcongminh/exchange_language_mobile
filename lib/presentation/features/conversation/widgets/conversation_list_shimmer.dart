import 'dart:math';

import 'package:exchange_language_mobile/presentation/theme/chat_style.dart';
import 'package:exchange_language_mobile/presentation/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConversationListShimmer extends StatelessWidget {
  const ConversationListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    bool isMe = random.nextBool();
    return ListView.builder(
      padding: EdgeInsets.only(top: 30.sp),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        int numberOfRow = random.nextInt(2) + 1;
        isMe = !isMe;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            SizedBox(width: 10.sp),
            !isMe
                ? AppShimmer.round(size: 40.sp)
                : SizedBox(width: 20.sp, height: 20.sp),
            Container(
              margin: EdgeInsets.only(
                right: 12.sp,
                left: 8.sp,
                bottom: 16.sp,
              ),
              decoration: BoxDecoration(
                color: colorBackgroundSender,
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
              ),
              constraints: BoxConstraints(
                maxWidth: 65.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppShimmer(width: 100.w, height: 12.sp),
                  numberOfRow == 2 ? SizedBox(height: 8.sp) : Container(),
                  numberOfRow == 2
                      ? AppShimmer(width: 35.w, height: 12.sp)
                      : const SizedBox.shrink(),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
