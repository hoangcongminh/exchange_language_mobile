import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/notification_style.dart';
import '../../../widgets/avatar_widget.dart';

class NotificationItem extends StatelessWidget {
  final bool isSeen;
  const NotificationItem({Key? key, required this.isSeen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isSeen ? colorBackgroundNotificationSeen : null,
      leading: AvatarWidget(height: 40.sp, width: 40.sp),
      title: const Text('Notification'),
      subtitle: const Text('Notification'),
    );
  }
}
