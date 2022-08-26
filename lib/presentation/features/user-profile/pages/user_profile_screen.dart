import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/features/conversation/bloc/conversation_bloc.dart';
import 'package:exchange_language_mobile/presentation/theme/colors.dart';
import 'package:exchange_language_mobile/presentation/widgets/app_button_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/loading_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../bloc/friend-bloc/friend_bloc.dart';
import '../bloc/user-profile-bloc/user_profile_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
                      centerTitle: true,
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
                        if (state.user.role == 1)
                          TextButton.icon(
                            onPressed: null,
                            icon: const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            label: Text(
                              state.star.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
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
                            SizedBox(height: 8.sp),

                            // 1 is teacher
                            if (state.user.role == 1 && !isMe)
                              RatingBar.builder(
                                initialRating: state.rated?.toDouble() ?? 0.0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                glow: false,
                                tapOnlyMode: true,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {
                                  AppBloc.userProfileBloc.add(RateTeacherEvent(
                                    userId: state.user.id,
                                    star: rating.toInt(),
                                  ));
                                },
                              ),
                            if (!isMe)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16.sp, right: 16.sp, top: 8.sp),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:
                                          BlocBuilder<FriendBloc, FriendState>(
                                        builder: (context, friendState) {
                                          if (friendState.friendStatus ==
                                              FriendStatus.NOT_FRIEND) {
                                            return AppButtonWidget(
                                              label: Text(l10n.addFriend),
                                              onPressed: () => AppBloc
                                                  .friendBloc
                                                  .add(AddFriendEvent(
                                                      userId: state.user.id)),
                                            );
                                          } else if (friendState.friendStatus ==
                                              FriendStatus.FRIEND) {
                                            return AppButtonWidget(
                                              label: Text(l10n.friend),
                                              onPressed: () {
                                                onTapFriendButton(
                                                    context, state);
                                              },
                                            );
                                          } else if (friendState.friendStatus ==
                                              FriendStatus.RECEIVER) {
                                            return AppButtonWidget(
                                              label: Text(
                                                  l10n.sentYouAFriendRequest),
                                              onPressed: () {
                                                onTapFriendResponseButton(
                                                    context, state);
                                              },
                                            );
                                          } else if (friendState.friendStatus ==
                                              FriendStatus.SENDER) {
                                            return AppButtonWidget(
                                              label: Text(l10n.requestSent),
                                              onPressed: () {},
                                            );
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.sp,
                                    ),
                                    AppButtonWidget(
                                      label: const Icon(Icons.chat),
                                      color: Colors.grey,
                                      onPressed: () {
                                        AppBloc.conversationBloc.add(
                                            CreateOrGetMessage(
                                                userId: state.user.id));
                                        AppNavigator()
                                            .push(RouteConstants.conversation);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            SizedBox(height: 20.sp),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  UserInfoItem(
                                    title: l10n.role,
                                    value: state.user.role == 1
                                        ? l10n.teacher
                                        : l10n.learner,
                                  ),
                                  const VerticalDivider(
                                    thickness: 2,
                                  ),
                                  UserInfoItem(
                                    title: l10n.speaking,
                                    value: state.user.speakingLanguage ==
                                                null ||
                                            state.user.speakingLanguage!.isEmpty
                                        ? ''
                                        : state
                                            .user.speakingLanguage!.first.name,
                                  ),
                                  const VerticalDivider(
                                    thickness: 2,
                                  ),
                                  UserInfoItem(
                                    title: l10n.learning,
                                    value: state.user.learningLanguage ==
                                                null ||
                                            state.user.learningLanguage!.isEmpty
                                        ? ''
                                        : state
                                            .user.learningLanguage!.first.name,
                                  ),
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
          return Scaffold(appBar: AppBar(), body: const LoadingWidget());
        }
      }),
    );
  }

  Future<dynamic> onTapFriendButton(
      BuildContext context, UserProfileLoaded state) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 100.sp,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.sp),
                TextButton(
                  onPressed: () {
                    AppBloc.friendBloc.add(DeleteFriend(userId: state.user.id));
                    AppNavigator().pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: Row(
                      children: [
                        const Icon(Icons.person_off_rounded),
                        SizedBox(width: 12.sp),
                        Text(
                          context.l10n.unFriend,
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: const Color(0xFFC5D0CF),
                  thickness: 0.3.sp,
                  height: 0.3.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> onTapFriendResponseButton(
      BuildContext context, UserProfileLoaded state) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150.sp,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.sp),
                TextButton(
                  onPressed: () {
                    AppBloc.friendBloc
                        .add(ConfirmFriendRequest(userId: state.user.id));
                    AppNavigator().pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: Row(
                      children: [
                        const Icon(Icons.check),
                        SizedBox(width: 12.sp),
                        Text(
                          context.l10n.confirm,
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AppBloc.friendBloc
                        .add(CancelFriendRequest(userId: state.user.id));
                    AppNavigator().pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: Row(
                      children: [
                        const Icon(Icons.cancel),
                        SizedBox(width: 12.sp),
                        Text(
                          context.l10n.cancel,
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: const Color(0xFFC5D0CF),
                  thickness: 0.3.sp,
                  height: 0.3.sp,
                ),
              ],
            ),
          ),
        );
      },
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
