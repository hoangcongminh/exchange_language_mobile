import 'package:exchange_language_mobile/presentation/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AvatarWidget(height: 40.sp, width: 40.sp),
      title: const Text('Notification'),
      subtitle: const Text('Notification'),
    );
  }
}
