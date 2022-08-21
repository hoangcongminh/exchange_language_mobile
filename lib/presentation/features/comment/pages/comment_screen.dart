import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/post.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../comment/bloc/comment_bloc.dart';
import '../../user-profile/bloc/user_profile_bloc.dart';
import '../widgets/comment_box.dart';

class CommentScreen extends StatefulWidget {
  final Post post;
  const CommentScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  String? replyTo;
  String? idReplyTo;

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          // title: const PostHeader(),
          centerTitle: false,
        ),
        body: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.comments.length,
                        itemBuilder: (context, index) {
                          final comment = state.comments[index];
                          return CommentTreeWidget<Comment, Comment>(
                            Comment(
                                avatar:
                                    '${AppConstants.baseImageUrl}${comment.author.avatar?.src}',
                                userName: comment.author.fullname,
                                content: comment.content),
                            comment.replys == null && comment.replys!.isEmpty
                                ? []
                                : comment.replys!
                                    .map((comment) => Comment(
                                        avatar:
                                            '${AppConstants.baseImageUrl}${comment.author.avatar?.src}',
                                        userName: comment.author.fullname,
                                        content: comment.content))
                                    .toList(),
                            treeThemeData: TreeThemeData(
                                lineColor: Colors.grey.shade300, lineWidth: 2),
                            avatarRoot: (context, data) => PreferredSize(
                              preferredSize: const Size.fromRadius(18),
                              child: GestureDetector(
                                onTap: () {
                                  AppBloc.userProfileBloc.add(
                                      GetUserProfileEvent(
                                          userId: comment.author.id));
                                  AppNavigator()
                                      .push(RouteConstants.userProfile);
                                },
                                child: AvatarWidget(
                                  height: 40,
                                  width: 40,
                                  imageUrl: data.avatar,
                                ),
                              ),
                            ),
                            avatarChild: (context, data) => PreferredSize(
                              preferredSize: const Size.fromRadius(12),
                              child: AvatarWidget(
                                height: 38,
                                width: 38,
                                imageUrl: data.avatar,
                              ),
                            ),
                            contentRoot: (context, data) {
                              return CommentItem(
                                userName: data.userName,
                                content: data.content,
                                onTapLike: () {},
                                onTapReply: () {
                                  setState(() {
                                    replyTo = comment.author.fullname;
                                    idReplyTo = comment.id;
                                  });
                                  _focusNode.requestFocus();
                                },
                              );
                            },
                            contentChild: (context, data) {
                              return CommentItem(
                                userName: data.userName,
                                content: data.content,
                                onTapLike: () {},
                                onTapReply: () {
                                  setState(() {
                                    replyTo = comment.author.fullname;
                                    idReplyTo = comment.id;
                                    _focusNode.requestFocus();
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  replyTo != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Replying to ',
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: replyTo,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black))
                                  ],
                                ),
                              ),
                              const Text(' - '),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    replyTo = null;
                                  });
                                },
                                child: Text(l10n.cancel),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  CommentBox(
                    focusNode: _focusNode,
                    onPostComment: (commentContent) {
                      AppBloc.commentBloc.add(
                        CommentToPostEvent(
                          postId: widget.post.id,
                          idPostReply: idReplyTo = idReplyTo,
                          content: commentContent,
                        ),
                      );
                      setState(() {
                        replyTo = null;
                        idReplyTo = null;
                      });
                    },
                  )
                ],
              );
            } else {
              return const LoadingWidget();
            }
          },
        ),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final String? userName;
  final String? content;
  final VoidCallback onTapLike;
  final VoidCallback onTapReply;

  const CommentItem({
    Key? key,
    required this.userName,
    required this.content,
    required this.onTapLike,
    required this.onTapReply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
                GestureDetector(onTap: onTapLike, child: Text(l10n.like)),
                const SizedBox(
                  width: 24,
                ),
                GestureDetector(onTap: onTapReply, child: Text(l10n.reply)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
