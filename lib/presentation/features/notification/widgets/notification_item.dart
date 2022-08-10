import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/notification_style.dart';
import '../../../widgets/avatar_widget.dart';

class NotificationItem extends StatelessWidget {
  final bool isSeen;
  const NotificationItem({Key? key, required this.isSeen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   tileColor: isSeen ? colorBackgroundNotificationSeen : null,
    //   leading: AvatarWidget(height: 40.sp, width: 40.sp),
    //   title: const Text('Notification'),
    //   subtitle: const Text('Notification'),
    // );
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: ListTile(
        tileColor: isSeen ? colorBackgroundNotificationSeen : null,
        leading: AvatarWidget(height: 40.sp, width: 40.sp),
        title: const Text('Notification'),
        subtitle: const Text('Notification'),
      ),
    );
  }
}
