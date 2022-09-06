import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../blog-detail/bloc/blog_detail_bloc.dart';
import '../bloc/blog_bloc.dart';
import '../widgets/blog_item.dart';

class BlogScreen extends StatefulWidget {
  final bool isUserProfile;
  final String? userId;

  const BlogScreen({
    Key? key,
    required this.isUserProfile,
    this.userId,
  }) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() {
    AppBloc.blogBloc.add(RefreshBlogsEvent());
    _refreshController.resetNoData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    AppBloc.blogBloc.add(FetchBlogsEvent());
    if (AppBloc.blogBloc.total == AppBloc.blogBloc.blogs.length) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogsLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Column(
                children: [
                  // Expanded(
                  //   flex: 1,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: 3,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Padding(
                  //         padding: EdgeInsets.only(right: 8.sp),
                  //         child: const Chip(
                  //           label: Text('English'),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  Expanded(
                    // flex: 8,
                    child: SmartRefresher(
                      header: const WaterDropHeader(),
                      onRefresh: _onRefresh,
                      controller: _refreshController,
                      onLoading: _onLoading,
                      enablePullUp: true,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final blog = widget.isUserProfile
                              ? state.blogs
                                  .where((element) =>
                                      element.author.id == widget.userId)
                                  .toList()[index]
                              : state.blogs[index];
                          return BlogItem(
                            title: blog.title,
                            thumbnail: blog.thumbnail,
                            author: blog.author.fullname,
                            createdAt: blog.createdAt,
                            onTap: () {
                              AppBloc.blogDetailBloc.add(
                                FetchBlogDetail(
                                  slug: blog.slug,
                                ),
                              );
                              AppNavigator().push(RouteConstants.blogDetail);
                            },
                          );
                        },
                        itemCount: widget.isUserProfile
                            ? state.blogs
                                .where((element) =>
                                    element.author.id == widget.userId)
                                .toList()
                                .length
                            : state.blogs.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is BlogsLoadFailure) {
            return ErrorScreen(
                onTapRefresh: () => AppBloc.blogBloc.add(RefreshBlogsEvent()));
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
