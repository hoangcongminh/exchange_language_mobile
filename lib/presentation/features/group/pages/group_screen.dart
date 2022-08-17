import 'package:exchange_language_mobile/presentation/features/group-detail/bloc/post-bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/loading_widget.dart';
import '../../group-detail/bloc/group-detail-bloc/group_detail_bloc.dart';
import '../bloc/group_bloc.dart';
import '../widget/group_item.dart';

class GroupScreen extends StatefulWidget {
  final bool isUserProfile;
  final String? userId;
  const GroupScreen({
    Key? key,
    required this.isUserProfile,
    this.userId,
  }) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() {
    AppBloc.groupBloc.add(RefreshGroupsEvent());
    _refreshController.resetNoData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    AppBloc.groupBloc.add(FetchGroupsEvent());
    if (AppBloc.groupBloc.total == AppBloc.groupBloc.groups.length) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Column(
                children: [
                  Expanded(
                    child: SmartRefresher(
                      header: const WaterDropHeader(),
                      onRefresh: _onRefresh,
                      controller: _refreshController,
                      onLoading: _onLoading,
                      enablePullUp: true,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final group = widget.isUserProfile
                              ? state.groups
                                  .where((element) =>
                                      element.members.contains(widget.userId))
                                  .toList()[index]
                              : state.groups[index];
                          return GestureDetector(
                            onTap: () {
                              AppBloc.groupDetailBloc
                                  .add(FetchGroupDetail(slug: group.slug));
                              AppBloc.postBloc
                                  .add(RefreshPostEvent(groupId: group.id));
                              AppNavigator().push(RouteConstants.groupDetail);
                            },
                            child: GroupItem(
                                groupName: group.title,
                                author: group.author,
                                thumbnail: group.thumbnail,
                                description: group.description,
                                memberCount: group.members.length,
                                isJoined: group.members
                                    .contains(UserLocal().getUser()!.id)),
                          );
                        },
                        itemCount: widget.isUserProfile
                            ? state.groups
                                .where((element) =>
                                    element.members.contains(widget.userId))
                                .toList()
                                .length
                            : state.groups.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
