import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/group_style.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/app_image_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../group/widget/create_post_widget.dart';
import '../../group/widget/post_item.dart';
import '../bloc/group-detail-bloc/group_detail_bloc.dart';
import '../bloc/post-bloc/post_bloc.dart';

class GroupDetail extends StatelessWidget {
  GroupDetail({Key? key}) : super(key: key);

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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

  void _onTapJoined(BuildContext context) {
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: Row(
                    children: [
                      const Icon(Icons.exit_to_app_outlined),
                      SizedBox(width: 12.sp),
                      Text(
                        'Leave group',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
    return BlocBuilder<GroupDetailBloc, GroupDetailState>(
      builder: (context, state) {
        if (state is GroupDetailLoaded) {
          final group = state.group;
          final isContainUser =
              group.members.contains(UserLocal().getUser()!.id);
          return Scaffold(
            backgroundColor: const Color(0xffC4C4C4),
            appBar: AppBar(
              title: Text(group.title),
              actions: group.members.contains(UserLocal().getUser()!.id)
                  ? [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ]
                  : null,
            ),
            body: SmartRefresher(
              header: const WaterDropHeader(),
              onRefresh: () {
                _onRefresh(state.group.id);
              },
              controller: _refreshController,
              onLoading: () {
                _onLoading(state.group.id);
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
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: isContainUser
                                ? AppButtonWidget(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.sp),
                                    ),
                                    onPressed: () => _onTapJoined(context),
                                    label: const Text('Joined'),
                                  )
                                : AppButtonWidget(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.sp),
                                    ),
                                    onPressed: () =>
                                        AppBloc.groupDetailBloc.add(
                                      JoinGroup(id: group.id, slug: group.slug),
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
                              final isLiked = state.posts[index].favorites
                                  .contains(UserLocal().getUser()!.id);
                              return Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(top: 5.sp),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.sp, vertical: 8.sp),
                                child: PostItem(
                                  isLiked: isLiked,
                                  onTapLike: () {
                                    AppBloc.postBloc.add(
                                      LikePostEvent(
                                        postId: post.id,
                                        groupId: post.group,
                                      ),
                                    );
                                  },
                                  isPostDetail: false,
                                  post: post,
                                ),
                              );
                            },
                            childCount: state.posts.length,
                          ),
                        );
                      } else {
                        return const SliverToBoxAdapter(child: LoadingWidget());
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
