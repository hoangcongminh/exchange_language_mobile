import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/media.dart';
import '../../../../domain/entities/user.dart';
import '../../../theme/colors.dart';
import '../../../theme/group_style.dart';
import '../../../widgets/app_image_widget.dart';

class GroupItem extends StatelessWidget {
  final String groupName;
  final User author;
  final Media? thumbnail;
  final String description;
  final int memberCount;
  final bool isJoined;
  final bool isPrivate;
  const GroupItem({
    Key? key,
    required this.groupName,
    required this.author,
    required this.thumbnail,
    required this.description,
    required this.memberCount,
    required this.isJoined,
    required this.isPrivate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: Card(
        shadowColor: const Color(0xFF828282),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            children: [
              ListTile(
                leading: AppImageWidget(
                  height: 40.sp,
                  width: 40.sp,
                  shape: BoxShape.circle,
                  imageUrl: thumbnail == null
                      ? null
                      : '${AppConstants.baseImageUrl}${thumbnail!.src}',
                ),
                title: Text(groupName, style: groupItemTitle),
                subtitle: Row(
                  children: [
                    Icon(
                      isPrivate ? Icons.lock : Icons.public,
                      color: Colors.grey,
                      size: 10.sp,
                    ),
                    SizedBox(width: 2.sp),
                    const Text('-'),
                    SizedBox(width: 2.sp),
                    Text(author.fullname, style: groupItemAuthorName),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  child: Text(description, style: groupInfoDescription),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Row(
                  children: [
                    const Icon(Icons.people, color: AppColors.primaryColor),
                    const SizedBox(width: 4),
                    Text(memberCount.toString()),
                    SizedBox(width: 10.sp),
                    const Spacer(),
                    isJoined
                        ? Row(
                            children: [
                              const Icon(Icons.check),
                              Text(l10n.joined),
                            ],
                          )
                        : const SizedBox.shrink(),
                    // : AppButtonWidget(
                    //     label: Text(l10n.join),
                    //     onPressed: () {},
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(20.sp),
                    //     ),
                    //   ),
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
