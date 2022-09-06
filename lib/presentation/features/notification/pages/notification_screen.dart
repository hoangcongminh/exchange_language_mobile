import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/features/group-detail-members/bloc/group_detail_members_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/group-detail/bloc/group-detail-bloc/group_detail_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/notification/widgets/notification_shimmer_list.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/repositories/post_repository_impl.dart';
import '../../../common/app_bloc.dart';
import '../../comment/bloc/comment_bloc.dart';
import '../../group-detail/bloc/post-bloc/post_bloc.dart';
import '../../user-profile/bloc/user-profile-bloc/user_profile_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../widgets/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() {
    AppBloc.notificationBloc.add(FetchNotificaton());
    _refreshController.resetNoData();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notification),
      ),
      // body: const NotificationShimmerList(),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded) {
            return SmartRefresher(
              header: const WaterDropHeader(),
              onRefresh: _onRefresh,
              controller: _refreshController,
              // onLoading: _onLoading,
              // enablePullUp: true,
              child: ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      switch (state.notifications[index].type) {
                        case 0:
                          break;
                        case 1:
                          AppBloc.userProfileBloc.add(GetUserProfileEvent(
                              userId: state.notifications[index].dataTarget!));
                          AppNavigator().push(RouteConstants.userProfile);
                          break;
                        case 2:
                          AppBloc.userProfileBloc.add(GetUserProfileEvent(
                              userId: state.notifications[index].dataTarget!));
                          AppNavigator().push(RouteConstants.userProfile);
                          break;
                        case 3:
                          await PostRepositoryImpl()
                              .getPostDetail(
                                postId: state.notifications[index].dataTarget!,
                              )
                              .then((value) => value.fold(
                                    (failure) {
                                      return null;
                                    },
                                    (post) {
                                      AppBloc.commentBloc.add(
                                          FetchCommentEvent(postId: post.id));
                                      AppNavigator().push(
                                          RouteConstants.comment,
                                          arguments: {'post': post});
                                    },
                                  ));
                          break;
                        case 4:
                          await PostRepositoryImpl()
                              .getPostDetail(
                                postId: state.notifications[index].dataTarget!,
                              )
                              .then((value) => value.fold((failure) {
                                    return null;
                                  }, (post) {
                                    AppBloc.commentBloc.add(
                                        FetchCommentEvent(postId: post.id));
                                    AppNavigator().push(RouteConstants.comment,
                                        arguments: {'post': post});
                                  }));
                          break;
                        case 5:
                          break;
                        case 6:
                          break;
                        case 7:
                          AppBloc.groupDetailMembersBloc.add(FetchGroupRequests(
                              groupId: state.notifications[index].dataTarget!));
                          AppNavigator().push(RouteConstants.groupDetailMembers,
                              arguments: {
                                'groupId':
                                    state.notifications[index].dataTarget!
                              });
                          break;
                        case 8:
                          AppBloc.groupDetailBloc.add(FetchGroupDetail(
                              groupId: state.notifications[index].dataTarget!));
                          AppBloc.postBloc.add(RefreshPostEvent(
                              groupId: state.notifications[index].dataTarget!));
                          AppNavigator().push(RouteConstants.groupDetail);
                          break;
                      }
                      AppBloc.notificationBloc.add(SeenNotification(
                          notificationId: state.notifications[index].id));
                    },
                    child: NotificationItem(
                      onDelete: () {
                        AppBloc.notificationBloc.add(DeleteNotification(
                            notificationId: state.notifications[index].id));
                      },
                      notification: state.notifications[index],
                    ),
                  );
                },
              ),
            );
          } else {
            return const NotificationShimmerList();
          }
        },
      ),
    );
  }
}
