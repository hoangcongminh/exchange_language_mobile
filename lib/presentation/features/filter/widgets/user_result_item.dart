import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../domain/entities/user.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/filter_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../user-profile/bloc/user-profile-bloc/user_profile_bloc.dart';

class UserResultItem extends StatelessWidget {
  const UserResultItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return GestureDetector(
      onTap: () {
        AppBloc.userProfileBloc.add(GetUserProfileEvent(userId: user.id));
        AppNavigator().push(RouteConstants.userProfile);
      },
      child: Card(
        borderOnForeground: false,
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
                      imageUrl: user.avatar == null
                          ? null
                          : '${AppConstants.baseImageUrl}${user.avatar!.src}',
                    ),
                  ),
                  SizedBox(
                    width: 8.sp,
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
                                l10n.speaking,
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
                                l10n.learning,
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
      ),
    );
  }
}
