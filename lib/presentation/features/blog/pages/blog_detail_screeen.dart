import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:translator/translator.dart';

import '../../../../routes/app_pages.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/loading_widget.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({Key? key}) : super(key: key);

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  quill.QuillController? _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadFromAssets();
  }

  Future<void> _loadFromAssets() async {
    try {
      final result = await rootBundle.loadString('assets/sample_data.json');
      final doc = quill.Document.fromJson(jsonDecode(result));
      setState(() {
        _controller = quill.QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
          onSelectionChanged: (textSelections) {
            final text = _controller!.document.getPlainText(
                textSelections.baseOffset,
                textSelections.extentOffset - textSelections.baseOffset);
            if (textSelections.baseOffset == textSelections.extentOffset) {
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
          },
        );
      });
    } catch (error) {
      final doc = quill.Document()..insert(0, 'Empty asset');
      setState(() {
        _controller = quill.QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            const AvatarWidget(
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Jenny Huynh'),
                Text('20 minutes ago'),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
          ),
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
          ),
        ),
      ),
    );
  }
}
