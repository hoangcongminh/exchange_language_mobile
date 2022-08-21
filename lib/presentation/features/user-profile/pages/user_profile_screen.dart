import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/theme/colors.dart';
import 'package:exchange_language_mobile/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/user_profile_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../blog/pages/blog_screen.dart';
import '../../discover/widgets/colored_tabbar.dart';
import '../../group/pages/group_screen.dart';
import '../bloc/user_profile_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // bool isMe =
    //     widget.user?.id == UserLocal().getUser()!.id || widget.user == null;
    // User? user = widget.user ?? UserLocal().getUser();

    return Scaffold(
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
        if (state is UserProfileLoaded) {
          bool isMe = state.user.id == UserLocal().getUser()!.id;
          return Container(
            color: AppColors.primaryColor,
            child: SafeArea(
              bottom: false,
              child: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      leading: AppNavigator().canPop
                          ? IconButton(
                              onPressed: () {
                                AppBloc.userProfileBloc.add(
                                  GetUserProfileEvent(
                                    userId: UserLocal().getUser()!.id,
                                  ),
                                );
                                AppNavigator().pop();
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                            )
                          : null,
                      title: Text(state.user.fullname),
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
                      child: Container(
                        color: Colors.white,
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          width: 5,
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: AvatarWidget(
                                        imageUrl: state.user.avatar == null
                                            ? null
                                            : '${AppConstants.baseImageUrl}${state.user.avatar!.src}',
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
                              state.user.introduction ?? '',
                              style: userIntroduction,
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              glow: false,
                              tapOnlyMode: true,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (rating) {},
                            ),
                            SizedBox(height: 20.sp),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  UserInfoItem(
                                      title: l10n.location, value: 'Viet Nam'),
                                  const VerticalDivider(
                                    thickness: 2,
                                  ),
                                  const UserInfoItem(
                                      title: 'Speaking', value: 'Vietnamese'),
                                  const VerticalDivider(
                                    thickness: 2,
                                  ),
                                  const UserInfoItem(
                                      title: 'Learning', value: 'English'),
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
                    ),
                  ],
                  body: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: TabBarView(
                      children: [
                        GroupScreen(
                          isUserProfile: true,
                          userId: state.user.id,
                        ),
                        BlogScreen(
                          isUserProfile: true,
                          userId: state.user.id,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const LoadingWidget();
        }
      }),
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
