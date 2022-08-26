import 'dart:convert';
import 'dart:io';

import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/blog_style.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/pick_image_widget.dart';
import '../../blog/bloc/blog_bloc.dart';
import '../../create-blog/bloc/create_blog_bloc.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({Key? key}) : super(key: key);

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  File? _imagePicked;
  final quill.QuillController _controller = quill.QuillController(
      document: quill.Document(),
      selection: const TextSelection.collapsed(offset: 0));
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<CreateBlogBloc, CreateBlogState>(
      listener: (context, state) {
        if (state is CreateBlogFailure) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              errorTitle: l10n.createBlogError,
              errorMessage: state.error,
            ),
          );
        } else if (state is CreateBlogSuccess) {
          AppBloc.blogBloc.add(RefreshBlogsEvent());
          AppNavigator().pop();
          toast(l10n.blogCreated);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.createBlog),
            actions: [
              IconButton(
                onPressed: _onCreateBlog,
                icon: const Icon(Icons.check),
              ),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              RawKeyboardListener(
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
                              PickImageWidget(
                                size: 80,
                                icon: Icons.image,
                                shape: BoxShape.rectangle,
                                onImagePicked: (file) {
                                  setState(() {
                                    _imagePicked = file;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 4.sp,
                              ),
                              Expanded(
                                child: TextFormField(
                                  autofocus: true,
                                  controller: _titleController,
                                  style: createBlogTitle,
                                  decoration: InputDecoration(
                                    hintText: l10n.addATitle,
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
                          onImagePickCallback: (file) async {
                            return file.absolute.path;
                          },
                          onVideoPickCallback: (file) async {
                            return file.absolute.path;
                          },
                        ),
                      ],
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
          ),
        );
      },
    );
  }

  _onCreateBlog() {
    AppBloc.createBlogBloc.add(
      CreateNewBlogEvent(
        thubmnail: _imagePicked,
        title: _titleController.text,
        content: jsonEncode(_controller.document.toDelta().toJson()),
      ),
    );
  }
}
