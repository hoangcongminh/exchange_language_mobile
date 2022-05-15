import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/avatar_widget.dart';
import '../../blog/pages/blog_screen.dart';
import '../../discover/widgets/colored_tabbar.dart';
import '../../group/group_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(UserLocal().getUser()?.fullname ?? l10n.profile),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => AppNavigator().push(RouteConstants.setting),
            ),
          ],
        ),
        // body: NestedScrollView(
        //   headerSliverBuilder: (context, innerBoxIsScrolled) {
        //     return [
        //       SliverAppBar(
        //         elevation: 0,
        //         title: Text(l10n.profile),
        //         actions: [
        //           IconButton(
        //             icon: const Icon(Icons.settings),
        //             onPressed: () =>
        //                 AppNavigator().push(RouteConstants.setting),
        //           ),
        //         ],
        //         bottom: const ColoredTabBar(
        //           color: Colors.white,
        //           tabBar: TabBar(
        //             tabs: [
        //               Tab(text: 'Group'),
        //               Tab(text: 'Blog'),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ];
        //   },
        //   body: const Expanded(
        //     child: TabBarView(
        //       children: [
        //         GroupScreen(),
        //         BlogScreen(),
        //       ],
        //     ),
        //   ),
        // ),
        body: Column(
          children: [
            Column(
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
                                'https://www.w3schools.com/howto/img_avatar.png',
                            width: 90.sp,
                            height: 90.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text('“ Lorem Ipsum is simply dummy text“'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    UserInfoItem(title: 'Location', value: 'Viet Nam'),
                    VerticalDivider(),
                    UserInfoItem(title: 'Speaking', value: 'Vietnamese'),
                    VerticalDivider(),
                    UserInfoItem(title: 'Learning', value: 'English'),
                  ],
                ),
                const ColoredTabBar(
                  color: Colors.white,
                  tabBar: TabBar(
                    tabs: [
                      Tab(text: 'Group'),
                      Tab(text: 'Blog'),
                    ],
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  GroupScreen(),
                  BlogScreen(),
                ],
              ),
            ),
          ],
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
            Text(title),
            Text(value),
          ],
        )
      ],
    );
  }
}
