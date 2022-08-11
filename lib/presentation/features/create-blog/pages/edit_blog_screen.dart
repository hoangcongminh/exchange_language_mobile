import 'dart:convert';
import 'dart:io';

import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/features/blog/bloc/blog_bloc.dart';
import 'package:exchange_language_mobile/presentation/widgets/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/blog.dart';
import '../../../../routes/app_pages.dart';
import '../../../blog-detail/bloc/blog_detail_bloc.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/blog_style.dart';
import '../../../widgets/custom_image_picker.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/pick_image_widget.dart';
import '../../create-blog/bloc/create_blog_bloc.dart';

class EditBlogScreen extends StatefulWidget {
  final Blog blog;
  const EditBlogScreen({Key? key, required this.blog}) : super(key: key);

  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  File? _imagePicked;
  late quill.QuillController _controller;
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    _controller = quill.QuillController(
        document: quill.Document.fromJson(jsonDecode(widget.blog.content!)),
        selection: const TextSelection.collapsed(offset: 0));
    _titleController.text = widget.blog.title;
    return BlocConsumer<CreateBlogBloc, CreateBlogState>(
      listener: (context, state) {
        if (state is CreateBlogFailure) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              errorTitle: 'Create blog error',
              errorMessage: state.error,
            ),
          );
        } else if (state is EditBlogSuccess) {
          AppBloc.blogDetailBloc.add(FetchBlogDetail(slug: state.edittedSlug));
          AppBloc.blogBloc.add(RefreshBlogsEvent());
          AppNavigator().pop();
        }
      },
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text(l10n.createBlog),
                actions: [
                  IconButton(
                    onPressed: _onCreateBlog,
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
              body: RawKeyboardListener(
                focusNode: FocusNode(),
                child: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50.sp,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  CustomImagePicker().openImagePicker(
                                      context: context,
                                      handleFinish: (file) {
                                        setState(() {
                                          _imagePicked = file;
                                        });
                                      });
                                },
                                child: _imagePicked != null
                                    ? Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: _imagePicked == null
                                              ? null
                                              : DecorationImage(
                                                  image:
                                                      FileImage(_imagePicked!),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      )
                                    : AppImageWidget(
                                        width: 80,
                                        height: 80,
                                        imageUrl:
                                            '${AppConstants.baseImageUrl}${widget.blog.thumbnail.src}'),
                              ),
                              SizedBox(
                                width: 4.sp,
                              ),
                              Expanded(
                                child: TextFormField(
                                  autofocus: true,
                                  controller: _titleController,
                                  style: createBlogTitle,
                                  decoration: const InputDecoration(
                                    hintText: 'Add a title',
                                    hintStyle: createBlogTitleHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.sp),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(4.sp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.sp,
                              ),
                            ),
                            child: quill.QuillEditor(
                              controller: _controller,
                              focusNode: _focusNode,
                              scrollController: ScrollController(),
                              scrollable: true,
                              padding: EdgeInsets.zero,
                              autoFocus: false,
                              readOnly: false,
                              expands: false,
                              locale: const Locale('vi'),
                              showCursor: true,
                            ),
                          ),
                        ),
                        quill.QuillToolbar.basic(
                          controller: _controller,
                          showAlignmentButtons: true,
                          showVideoButton: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state is CreateBlogLoading)
              const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (state is CreateBlogLoading) const LoadingWidget()
          ],
        );
      },
    );
  }

  _onCreateBlog() {
    AppBloc.createBlogBloc.add(
      EditBlogEvent(
        thubmnail: _imagePicked,
        currentThumbnailId:
            _imagePicked == null ? widget.blog.thumbnail.id : null,
        title: _titleController.text,
        content: jsonEncode(_controller.document.toDelta().toJson()),
        blogId: widget.blog.id,
      ),
    );
  }
}
