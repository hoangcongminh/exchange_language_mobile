import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/datasources/local/user_local_data.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/group_style.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../group/widget/create_post_widget.dart';
import '../../group/widget/post_item.dart';
import '../bloc/group-detail-bloc/group_detail_bloc.dart';
import '../bloc/post-bloc/post_bloc.dart';

class GroupDetail extends StatelessWidget {
  const GroupDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<GroupDetailBloc, GroupDetailState>(
      builder: (context, state) {
        if (state is GroupDetailLoaded) {
          final group = state.group;
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
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ]
                  : null,
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: group.members.contains(UserLocal().getUser()!.id)
                      ? const CreatePostWidget()
                      : Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16.sp),
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
                              const SizedBox(height: 16),
                              Center(
                                child: AppButtonWidget(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  onPressed: () => AppBloc.groupDetailBloc.add(
                                      JoinGroup(
                                          id: group.id, slug: group.slug)),
                                  label: Text(l10n.join),
                                ),
                              )
                            ],
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
                            return Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 5.sp),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.sp, vertical: 8.sp),
                              child: PostItem(
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
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
