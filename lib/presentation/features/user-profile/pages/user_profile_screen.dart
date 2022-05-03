import 'package:exchange_language_mobile/presentation/common/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/bloc/authenticate_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/blog/pages/blog_screen.dart';
import 'package:exchange_language_mobile/presentation/features/discover/widgets/colored_tabbar.dart';
import 'package:exchange_language_mobile/presentation/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
          ),
          toolbarHeight: 30.h,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 70.sp,
                        width: double.infinity,
                        color: Theme.of(context).primaryColor,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AvatarWidget(
                          imageUrl:
                              'https://www.w3schools.com/howto/img_avatar.png',
                          width: 70.sp,
                          height: 70.sp,
                        ),
                      ),
                    ],
                  ),
                  const Text('“ Lorem Ipsum is simply dummy text“'),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        UserInfoItem(title: 'Location', value: 'Viet Nam'),
                        VerticalDivider(),
                        UserInfoItem(title: 'Speaking', value: 'Vietnamese'),
                        VerticalDivider(),
                        UserInfoItem(title: 'Learning', value: 'English'),
                      ],
                    ),
                  ),
                  ColoredTabBar(
                    color: Colors.white,
                    tabBar: TabBar(
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      labelColor: Theme.of(context).primaryColor,
                      tabs: const [
                        Tab(text: 'Group'),
                        Tab(text: 'Blog'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                AppBloc.authenticateBloc.add(LogoutEvent());
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text('Discover'),
            ),
            BlogScreen()
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
