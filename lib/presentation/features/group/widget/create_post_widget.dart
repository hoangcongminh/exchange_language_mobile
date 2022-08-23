import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../widgets/avatar_widget.dart';
import '../../create-post/pages/create_post_screen.dart';

class CreatePostWidget extends StatelessWidget {
  final String groupId;
  const CreatePostWidget({Key? key, required this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
        child: Row(
          children: [
            AvatarWidget(
              height: 40,
              width: 40,
              imageUrl:
                  '${AppConstants.baseImageUrl}${UserLocal().getUser()?.avatar?.src}',
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CreatePostScreen(
                          groupId: groupId,
                        );
                      });
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      l10n.createNewPost,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
