import 'package:exchange_language_mobile/common/helpers/utils/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:translator/translator.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/post.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/group_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/text_tap.dart';
import '../../group-detail/bloc/post-bloc/post_bloc.dart';

class PostItem extends StatelessWidget {
  final bool isPostDetail;
  final Post post;
  final bool isLiked;
  final VoidCallback onTapLike;

  const PostItem({
    Key? key,
    required this.isPostDetail,
    required this.post,
    required this.isLiked,
    required this.onTapLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isPostDetail
            ? const SizedBox.shrink()
            : PostHeader(
                authorName: post.author.fullname,
                createdAt: post.createdAt,
                authorAvatar: post.author.avatar?.src,
              ),
        const SizedBox(height: 8),
        Text(
          post.title,
          style: postTitle,
        ),
        const SizedBox(height: 8),
        TextTap(
          text: post.content,
          textStyle: postContent,
          textStyleSelect: const TextStyle(
            color: Colors.red,
          ),
          selectText: (text) async {
            final translator = GoogleTranslator();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => FutureBuilder<Translation>(
                future: translator.translate(text, to: 'vi'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const LoadingWidget();
                  }
                  return CupertinoAlertDialog(
                    title: const Text('Translation'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data!.sourceLanguage.name),
                        Text(snapshot.data!.source),
                        Text(snapshot.data!.targetLanguage.name),
                        Text(snapshot.data!.text),
                      ],
                    ),
                    actions: [
                      CupertinoDialogAction(
                          onPressed: () {
                            AppNavigator().pop();
                            TextTap.clear();
                          },
                          child: const Text('OK'))
                    ],
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        const Divider(thickness: 1),
        BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoaded) {}
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: onTapLike,
                  label: Text(post.favorites.length.toString()),
                  icon: isLiked
                      ? const Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.red,
                        )
                      : const Icon(
                          CupertinoIcons.heart,
                        ),
                ),
                TextButton.icon(
                  onPressed: isPostDetail
                      ? () {}
                      : () {
                          AppNavigator().push(RouteConstants.postDetail);
                        },
                  label: Text(post.comments.length.toString()),
                  icon: const Icon(CupertinoIcons.chat_bubble),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}

class PostHeader extends StatelessWidget {
  final String authorName;
  final String createdAt;
  final String? authorAvatar;
  const PostHeader({
    Key? key,
    required this.authorName,
    required this.createdAt,
    required this.authorAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarWidget(
          height: 30.sp,
          width: 30.sp,
          imageUrl: authorAvatar == null
              ? null
              : '${AppConstants.baseImageUrl}$authorAvatar',
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              authorName,
              style: postAuthorInfo,
            ),
            Text(
              createdAt.formatTime,
              style: postTime,
            ),
          ],
        )
      ],
    );
  }
}
