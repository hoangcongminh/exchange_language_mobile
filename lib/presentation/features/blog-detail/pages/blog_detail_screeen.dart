import 'dart:convert';

import 'package:exchange_language_mobile/common/helpers/translation_helper.dart';
import 'package:exchange_language_mobile/common/helpers/utils/string_extension.dart';
import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/blog_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../blog/bloc/blog_bloc.dart';
import '../../user-profile/bloc/user-profile-bloc/user_profile_bloc.dart';
import '../bloc/blog_detail_bloc.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({Key? key}) : super(key: key);

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  late quill.QuillController? _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<BlogDetailBloc, BlogDetailState>(
      listener: (context, state) {
        if (state is BlogDetailDeleted) {
          AppBloc.blogBloc.add(RefreshBlogsEvent());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is BlogDetailLoaded) {
          _controller = quill.QuillController(
              document:
                  quill.Document.fromJson(jsonDecode(state.blog.content!)),
              selection: const TextSelection.collapsed(offset: 0),
              onSelectionChanged: (textSelections) {
                final text = _controller!.document.getPlainText(
                    textSelections.baseOffset,
                    textSelections.extentOffset - textSelections.baseOffset);
                if (textSelections.baseOffset == textSelections.extentOffset) {
                  return;
                } else if (text == " ") {
                  return;
                } else {
                  TranslationHelper().showTranslate(context, text);
                }
              });
          final author = state.blog.author;
          final blog = state.blog;
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              titleSpacing: 0,
              actions: [
                if (state.blog.author.id == UserLocal().getUser()?.id)
                  IconButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            cancelButton: CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(l10n.cancel),
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  AppNavigator().push(
                                    RouteConstants.editBlog,
                                    arguments: {'blog': state.blog},
                                  );
                                },
                                child: Text(l10n.edit),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  AppBloc.blogDetailBloc
                                      .add(DeleteBlogEvent(id: state.blog.id));
                                },
                                child: Text(l10n.delete),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit))
              ],
              title: GestureDetector(
                onTap: () {
                  AppBloc.userProfileBloc
                      .add(GetUserProfileEvent(userId: blog.author.id));
                  AppNavigator().push(
                    RouteConstants.userProfile,
                  );
                },
                child: Row(
                  children: [
                    AvatarWidget(
                      width: 40,
                      height: 40,
                      imageUrl: blog.author.avatar == null
                          ? null
                          : '${AppConstants.baseImageUrl}${blog.author.avatar!.src}',
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(author.fullname, style: blogDetailAuthorName),
                        Text(
                          blog.createdAt.formatTime,
                          style: blogDetailCreatedDate,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.sp),
                    child: Center(
                      child: Text(
                        blog.title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: quill.QuillEditor(
                      controller: _controller!,
                      showCursor: false,
                      focusNode: _focusNode,
                      scrollController: ScrollController(),
                      scrollable: true,
                      padding: EdgeInsets.zero,
                      autoFocus: true,
                      readOnly: true,
                      expands: false,
                      locale: AppBloc.localeCubit.state,
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
    );
  }
}
