import 'dart:convert';

import 'package:exchange_language_mobile/common/helpers/utils/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:sizer/sizer.dart';
import 'package:translator/translator.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/blog_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/loading_widget.dart';
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
    return BlocBuilder<BlogDetailBloc, BlogDetailState>(
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
                                },
                                child: const Text('OK'))
                          ],
                        );
                      },
                    ),
                  );
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
                              child: const Text('Cancel'),
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
                                child: const Text('Edit'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.more_vert))
              ],
              title: Row(
                children: [
                  AvatarWidget(
                    width: 40,
                    height: 40,
                    imageUrl:
                        '${AppConstants.baseImageUrl}${blog.author.avatar.src}',
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
