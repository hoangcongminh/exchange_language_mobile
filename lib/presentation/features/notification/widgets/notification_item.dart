import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/domain/entities/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../theme/notification_style.dart';
import '../../../widgets/avatar_widget.dart';

class NotificationItem extends StatelessWidget {
  final Notificaton notification;
  final VoidCallback onDelete;
  const NotificationItem({
    Key? key,
    required this.notification,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? avatar;
    String? title;
    String? subTitle;
    // return ListTile(
    //   tileColor: isSeen ? colorBackgroundNotificationSeen : null,
    //   leading: AvatarWidget(height: 40.sp, width: 40.sp),
    //   title: const Text('Notification'),
    //   subtitle: const Text('Notification'),
    // );
    switch (notification.type) {
      case 1:
        avatar = notification.userSender?.avatar?.src;
        title =
            '${notification.userSender!.fullname} ${context.l10n.sentYouAFriendRequest}';
        break;
      case 2:
        avatar = notification.userSender?.avatar?.src;
        title =
            '${notification.userSender!.fullname} ${context.l10n.acceptedYourFriendRequest}';
        break;
      case 3:
        avatar = notification.userSender?.avatar?.src;
        title =
            '${notification.userSender!.fullname} ${context.l10n.likedYourPost}';
        break;
      case 4:
        avatar = notification.userSender?.avatar?.src;
        title =
            '${notification.userSender?.fullname} ${context.l10n.commentedOnYourPost}';
        break;
      case 5:
        avatar = notification.userSender?.avatar?.src;
        title =
            '${notification.userSender!.fullname} ${context.l10n.hasJoined} ${notification.dataTarget}';
        break;
      case 6:
        avatar = notification.userSender?.avatar?.src;
        title = '${notification.userSender!.fullname} ${context.l10n.ratedYou}';
        break;
    }
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onDelete();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: context.l10n.delete,
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: ListTile(
        // status = 0: notSeen, 1: seen
        tileColor:
            notification.status == 0 ? colorBackgroundNotificationSeen : null,
        leading: AvatarWidget(
          height: 40.sp,
          width: 40.sp,
          imageUrl:
              avatar == null ? null : '${AppConstants.baseImageUrl}$avatar',
        ),
        title: Text(title ?? ''),
        subtitle: Text(subTitle ?? ''),
      ),
    );
  }
}
