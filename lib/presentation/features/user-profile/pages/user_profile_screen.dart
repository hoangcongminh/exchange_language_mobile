import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../domain/entities/user.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/user_profile_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../blog/pages/blog_screen.dart';
import '../../discover/widgets/colored_tabbar.dart';
import '../../group/pages/group_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final User? user;
  const UserProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    bool isMe = widget.user == null;
    User? user = widget.user ?? UserLocal().getUser();

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(user?.fullname ?? l10n.profile),
              actions: [
                isMe
                    ? IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () =>
                            AppNavigator().push(RouteConstants.setting),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 55.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 5,
                              color: Theme.of(context).primaryColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 5,
                                color: Colors.white,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: AvatarWidget(
                              imageUrl:
                                  '${AppConstants.baseImageUrl}${user?.avatar.src ?? 'https://picsum.photos/200'}',
                              width: 90.sp,
                              height: 90.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.sp),
                  Text(
                    user?.introduction ?? '',
                    style: userIntroduction,
                  ),
                  SizedBox(height: 20.sp),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        UserInfoItem(title: 'Location', value: 'Viet Nam'),
                        VerticalDivider(
                          thickness: 2,
                        ),
                        UserInfoItem(title: 'Speaking', value: 'Vietnamese'),
                        VerticalDivider(
                          thickness: 2,
                        ),
                        UserInfoItem(title: 'Learning', value: 'English'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.sp),
                  ColoredTabBar(
                    color: Colors.white,
                    tabBar: TabBar(
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: l10n.group),
                        Tab(text: l10n.blog),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: const TabBarView(
              children: [
                GroupScreen(),
                BlogScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoItem extends StatelessWidget {
  const UserInfoItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(title, style: userInfoTitle),
            SizedBox(height: 4.sp),
            Text(value, style: userInfo),
          ],
        )
      ],
    );
  }
}
