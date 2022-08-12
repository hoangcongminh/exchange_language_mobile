import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/avatar_widget.dart';
import '../widget/post_item.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const PostHeader(),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            children: [
              // const PostItem(
              //   isPostDetail: true,
              // ),
              Divider(
                thickness: 1.sp,
              ),
              CommentTreeWidget<Comment, Comment>(
                Comment(
                    avatar: 'null',
                    userName: 'minh',
                    content: 'felangel made felangel/cubit_and_beyond public '),
                [
                  Comment(
                      avatar: 'null',
                      userName: 'user1',
                      content: 'A Dart template generator which helps teams'),
                  Comment(
                      avatar: 'null',
                      userName: 'user1',
                      content: 'A Dart template generator which helps teams'),
                  Comment(
                      avatar: 'null',
                      userName: 'user1',
                      content:
                          'A Dart template generator which helps teams \n A Dart template generator which helps teams \n A Dart template generator which helps teams'),
                  Comment(
                      avatar: 'null',
                      userName: 'user1',
                      content: 'A Dart template generator which helps teams'),
                  Comment(
                      avatar: 'null',
                      userName: 'minh',
                      content:
                          'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
                  Comment(
                      avatar: 'null',
                      userName: 'minh',
                      content: 'A Dart template generator which helps teams'),
                  Comment(
                      avatar: 'null',
                      userName: 'user1',
                      content:
                          'A Dart template generator which helps teams generator which helps teams '),
                ],
                treeThemeData: TreeThemeData(
                    lineColor: Colors.grey.shade300, lineWidth: 2),
                avatarRoot: (context, data) => const PreferredSize(
                  preferredSize: Size.fromRadius(18),
                  child: AvatarWidget(
                    height: 40,
                    width: 40,
                  ),
                ),
                avatarChild: (context, data) => const PreferredSize(
                  preferredSize: Size.fromRadius(12),
                  child: AvatarWidget(
                    height: 38,
                    width: 38,
                  ),
                ),
                contentChild: (context, data) {
                  return CommentItem(
                      userName: data.userName, content: data.content);
                },
                contentRoot: (context, data) {
                  return CommentItem(
                      userName: data.userName, content: data.content);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final String? userName;
  final String? content;
  const CommentItem({
    Key? key,
    required this.userName,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName ?? '',
                style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                content ?? '',
                style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w300, color: Colors.black),
              ),
            ],
          ),
        ),
        DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Colors.grey[700], fontWeight: FontWeight.bold),
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(onTap: () {}, child: const Text('Like')),
                const SizedBox(
                  width: 24,
                ),
                GestureDetector(onTap: () {}, child: const Text('Reply')),
              ],
            ),
          ),
        )
      ],
    );
  }
}
