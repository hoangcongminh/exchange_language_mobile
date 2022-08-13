import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/post_style.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../group-detail/bloc/post-bloc/post_bloc.dart';
import '../bloc/create_post_bloc.dart';

class CreatePostScreen extends StatefulWidget {
  final String groupId;
  const CreatePostScreen({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => AppNavigator().pop(),
            icon: const Icon(Icons.close)),
        title: const Text('Create post'),
        actions: [
          IconButton(
            onPressed: () => AppBloc.createPostBloc.add(CreateNewPostEvent(
              groupId: widget.groupId,
              postTitle: _titleController.text.trim(),
              postContent: _contentController.text.trim(),
            )),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: BlocConsumer<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state is CreatePostSuccess) {
            AppBloc.postBloc.add(RefreshPostEvent(groupId: widget.groupId));
            AppNavigator().pop();
          } else if (state is CreatePostFailure) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                errorTitle: 'Create post error',
                errorMessage: state.message,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
                top: 6.sp, bottom: 1.h, left: 12.sp, right: 12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: _titleController,
                  style: createPostTitle,
                  decoration: const InputDecoration(
                    hintText: 'Add a title',
                    hintStyle: createPostTitleHint,
                  ),
                ),
                TextFormField(
                  minLines: 10,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  controller: _contentController,
                  style: createPostContent,
                  decoration: const InputDecoration(
                    hintText: 'Share your thought...',
                    hintStyle: createPostContentHint,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // hintStyle: createBlogTitleHint,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
