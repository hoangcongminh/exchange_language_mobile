import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../domain/entities/user.dart';
import '../../../theme/filter_style.dart';
import '../../../widgets/avatar_widget.dart';

class UserResultItem extends StatelessWidget {
  const UserResultItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AvatarWidget(
                    height: 60.sp,
                    width: 60.sp,
                    imageUrl: '${AppConstants.baseImageUrl}${user.avatar.src}',
                  ),
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullname,
                        style: userResultItemName,
                      ),
                      SizedBox(
                        height: 4.sp,
                      ),
                      SizedBox(
                          child: Table(
                        children: [
                          TableRow(children: [
                            Text(
                              'Location',
                              style: userResultItemInfoTitle,
                            ),
                            Text(
                              user.fullname,
                              style: userResultItemInfo,
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Speaking',
                              style: userResultItemInfoTitle,
                            ),
                            Row(
                              children: [
                                Text(
                                  user.speakingLanguage == null ||
                                          user.speakingLanguage!.isEmpty
                                      ? ''
                                      : user.speakingLanguage!.first.name,
                                  style: userResultItemInfo,
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Learning',
                              style: userResultItemInfoTitle,
                            ),
                            Text(
                              user.learningLanguage == null ||
                                      user.learningLanguage!.isEmpty
                                  ? ''
                                  : user.learningLanguage!.first.name,
                              style: userResultItemInfo,
                            ),
                          ]),
                        ],
                      ))
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text(
              user.introduction ?? '',
              style: userResultItemInfoIntroduction,
            ),
          ],
        ),
      ),
    );
  }
}
