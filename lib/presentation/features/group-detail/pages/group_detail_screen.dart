import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/theme/colors.dart';
import 'package:exchange_language_mobile/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/group_style.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/app_image_widget.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../comment/bloc/comment_bloc.dart';
import '../../group/widget/create_post_widget.dart';
import '../../group/widget/post_item.dart';
import '../../user-profile/bloc/user-profile-bloc/user_profile_bloc.dart';
import '../bloc/group-detail-bloc/group_detail_bloc.dart';
import '../bloc/post-bloc/post_bloc.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({Key? key}) : super(key: key);

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool isShowSearchBar = false;

  void _onRefresh(String groupId) {
    AppBloc.postBloc.add(RefreshPostEvent(groupId: groupId));
    _refreshController.resetNoData();
    _refreshController.refreshCompleted();
  }

  void _onLoading(String groupId) async {
    AppBloc.postBloc.add(FetchPostsEvent(groupId: groupId));
    if (AppBloc.postBloc.total == AppBloc.postBloc.posts.length) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _onTapJoined(BuildContext context,
      {required String id, required String slug}) {
    showModalBottomSheet(
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
                  onPressed: () => AppBloc.groupDetailBloc
                      .add(LeaveGroup(id: id, slug: slug)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: Row(
                      children: [
                        const Icon(Icons.close),
                        SizedBox(width: 12.sp),
                        Text(
                          context.l10n.leaveGroup,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<GroupDetailBloc, GroupDetailState>(
      listener: (context, state) {
        if (state is GroupDetailLeaveSuccess) {
          AppNavigator().pushNamedAndRemoveUntil(RouteConstants.home);
          toast(context.l10n.leaveGroupSuccess);
        } else if (state is GroupDetailJoinSuccess) {
          AppBloc.groupDetailBloc.add(FetchGroupDetail(groupId: state.groupId));
          toast(context.l10n.joinGroupSuccess);
        }
      },
      builder: (context, groupState) {
        if (groupState is GroupDetailLoaded) {
          final group = groupState.group;
          final isContainUser =
              group.members.contains(UserLocal().getUser()!.id);
          return Scaffold(
            backgroundColor: const Color(0xffC4C4C4),
            appBar: AppBar(
              title: isShowSearchBar
                  ? SearchBox(onChanged: (text) {
                      AppBloc.postBloc.add(SearchPostEvent(
                          groupId: groupState.group.id, searchTitle: text));
                    })
                  : Text(group.title),
              titleSpacing: isShowSearchBar ? 0 : null,
              actions: group.members.contains(UserLocal().getUser()!.id)
                  ? [
                      IconButton(
                        icon:
                            Icon(isShowSearchBar ? Icons.cancel : Icons.search),
                        onPressed: () {
                          setState(() {
                            isShowSearchBar = !isShowSearchBar;
                          });
                        },
                      ),
                    ]
                  : null,
            ),
            body: SmartRefresher(
              header: const WaterDropHeader(),
              onRefresh: () {
                _onRefresh(groupState.group.id);
              },
              controller: _refreshController,
              onLoading: () {
                _onLoading(groupState.group.id);
              },
              enablePullUp: true,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      // padding: EdgeInsets.only(bottom: 16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppImageWidget(
                            height: 20.h,
                            width: 100.w,
                            fit: BoxFit.cover,
                            imageUrl: group.thumbnail == null
                                ? null
                                : '${AppConstants.baseImageUrl}${group.thumbnail!.src}',
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  group.title,
                                  style: groupInfoTitle,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.people),
                                    const SizedBox(width: 6),
                                    Text(
                                      group.members.length.toString(),
                                      style: groupInfoMemberCount,
                                    ),
                                  ],
                                ),
                                Text(
                                  group.description,
                                  style: groupInfoDescription,
                                ),
                                SizedBox(height: 6.sp),
                                Row(
                                  children: [
                                    Text(
                                      l10n.aGroupBy,
                                      style: groupInfoDescription,
                                    ),
                                    SizedBox(width: 2.sp),
                                    GestureDetector(
                                      onTap: () {
                                        AppBloc.userProfileBloc.add(
                                            GetUserProfileEvent(
                                                userId: group.author.id));
                                        AppNavigator()
                                            .push(RouteConstants.userProfile);
                                      },
                                      child: Text(
                                        group.author.fullname,
                                        style: groupInfoDescription.copyWith(
                                            color: AppColors.primaryColor),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (group.author.id != UserLocal().getUser()!.id)
                            Center(
                              child: isContainUser
                                  ? AppButtonWidget(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                      ),
                                      onPressed: () => _onTapJoined(context,
                                          id: group.id, slug: group.slug),
                                      label: Text(l10n.joined),
                                    )
                                  : AppButtonWidget(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                      ),
                                      onPressed: () =>
                                          AppBloc.groupDetailBloc.add(
                                        JoinGroup(
                                            id: group.id, groupId: group.id),
                                      ),
                                      label: Text(l10n.join),
                                    ),
                            ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  if (isContainUser)
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(top: 5.sp),
                        child: CreatePostWidget(
                          groupId: group.id,
                        ),
                      ),
                    ),
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state is PostLoaded) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final post = state.posts[index];
                              final isLiked =
                                  state.likedPosts.contains(post.id);
                              return Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(top: 5.sp),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.sp, vertical: 8.sp),
                                child: PostItem(
                                  isLiked: isLiked,
                                  onTapLike: () {
                                    if (!groupState.group.members
                                        .contains(UserLocal().getUser()!.id)) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => ErrorDialog(
                                          errorTitle: l10n.error,
                                          errorMessage:
                                              l10n.youMustJoinThisGroup,
                                        ),
                                      );
                                    } else {
                                      AppBloc.postBloc.add(
                                        LikePostEvent(
                                          postId: post.id,
                                          groupId: post.group,
                                        ),
                                      );
                                    }
                                  },
                                  onTapComment: () {
                                    if (!groupState.group.members
                                        .contains(UserLocal().getUser()!.id)) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => ErrorDialog(
                                          errorTitle: l10n.error,
                                          errorMessage:
                                              l10n.youMustJoinThisGroup,
                                        ),
                                      );
                                    } else {
                                      AppBloc.commentBloc.add(
                                          FetchCommentEvent(postId: post.id));
                                      AppNavigator().push(
                                          RouteConstants.comment,
                                          arguments: {'post': post});
                                    }
                                  },
                                  onTapPostHeader: () {
                                    AppBloc.userProfileBloc.add(
                                        GetUserProfileEvent(
                                            userId: post.author.id));
                                    AppNavigator()
                                        .push(RouteConstants.userProfile);
                                  },
                                  isPostDetail: false,
                                  post: post,
                                ),
                              );
                            },
                            childCount: state.posts.length,
                          ),
                        );
                      } else if (state is PostLoading) {
                        return const SliverToBoxAdapter(child: LoadingWidget());
                      } else {
                        return SliverToBoxAdapter(
                          child: ErrorScreen(
                              onTapRefresh: () => AppBloc.postBloc.add(
                                  RefreshPostEvent(
                                      groupId: groupState.group.id))),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: const LoadingWidget(),
          );
        }
      },
    );
  }
}
