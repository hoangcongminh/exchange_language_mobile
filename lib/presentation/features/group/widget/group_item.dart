import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/media.dart';
import '../../../../domain/entities/user.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/avatar_widget.dart';

class GroupItem extends StatelessWidget {
  final String groupName;
  final User author;
  final Media? thumbnail;
  final String description;
  final int memberCount;
  const GroupItem({
    Key? key,
    required this.groupName,
    required this.author,
    required this.thumbnail,
    required this.description,
    required this.memberCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: Card(
        shadowColor: const Color(0xFF828282),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            children: [
              ListTile(
                leading: AvatarWidget(
                  height: 30.sp,
                  width: 30.sp,
                  imageUrl: thumbnail == null
                      ? null
                      : '${AppConstants.baseImageUrl}${thumbnail!.src}',
                ),
                title: Text(groupName),
                subtitle: Text(author.fullname),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Text(description),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Row(
                  children: [
                    const Icon(Icons.people),
                    Text(memberCount.toString()),
                    SizedBox(width: 10.sp),
                    const Spacer(),
                    AppButtonWidget(
                      label: Text(l10n.join),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
