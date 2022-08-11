import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../blog-detail/bloc/blog_detail_bloc.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/loading_widget.dart';
import '../bloc/blog_bloc.dart';
import '../widgets/blog_item.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

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
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.sp),
                          child: const Chip(
                            label: Text('English'),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: SmartRefresher(
                      header: const WaterDropHeader(),
                      onRefresh: _onRefresh,
                      controller: _refreshController,
                      onLoading: _onLoading,
                      enablePullUp: true,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final blog = state.blogs[index];
                          return BlogItem(
                            title: blog.title,
                            thumbnail: blog.thumbnail,
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
                        itemCount: state.blogs.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is BlogsLoadFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('There are some error'),
                  TextButton(
                    onPressed: () => AppBloc.blogBloc.add(FetchBlogsEvent()),
                    child: const Text('Refresh'),
                  )
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
