import 'package:exchange_language_mobile/common/helpers/utils/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:translator/translator.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/user.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/group_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/text_tap.dart';

class PostItem extends StatelessWidget {
  final bool isPostDetail;
  final String title;
  final String content;
  final User author;
  final String createdAt;
  const PostItem({
    Key? key,
    required this.isPostDetail,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isPostDetail
            ? const SizedBox.shrink()
            : PostHeader(
                authorName: author.fullname,
                createdAt: createdAt,
                authorAvatar: author.avatar.src,
              ),
        const SizedBox(height: 8),
        Text(
          title,
          style: postTitle,
        ),
        const SizedBox(height: 8),
        TextTap(
          text: content,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {},
              label: const Text('18'),
              icon: const Icon(CupertinoIcons.heart),
            ),
            TextButton.icon(
              onPressed: isPostDetail
                  ? () {}
                  : () {
                      AppNavigator().push(RouteConstants.postDetail);
                    },
              label: const Text('4'),
              icon: const Icon(CupertinoIcons.chat_bubble),
            ),
          ],
        )
      ],
    );
  }
}

class PostHeader extends StatelessWidget {
  final String authorName;
  final String createdAt;
  final String authorAvatar;
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
          imageUrl: '${AppConstants.baseImageUrl}$authorAvatar',
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
