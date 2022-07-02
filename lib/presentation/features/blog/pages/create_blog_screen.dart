import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({Key? key}) : super(key: key);

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  quill.QuillController? _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final doc = quill.Document()..insert(0, 'Enter content');
    setState(() {
      _controller = quill.QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Blog'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: const Text('Text'),
                    content: Text(
                        _controller!.document.toDelta().toJson().toString())),
              );
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: quill.QuillEditor(
                    controller: _controller!,
                    focusNode: _focusNode,
                    scrollController: ScrollController(),
                    scrollable: true,
                    padding: EdgeInsets.zero,
                    autoFocus: true,
                    readOnly: false,
                    expands: false,
                    locale: const Locale('vi'),
                    showCursor: true,
                  ),
                ),
              ),
              quill.QuillToolbar.basic(
                controller: _controller!,
                showAlignmentButtons: true,
                showVideoButton: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
