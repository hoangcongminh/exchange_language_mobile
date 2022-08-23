import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatefulWidget {
  final Function(String) onPostComment;
  final FocusNode focusNode;
  const CommentBox({
    Key? key,
    required this.onPostComment,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  bool showSendButton = false;
  final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFf1f2f6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 1),
            blurRadius: 1,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              controller: _contentController,
              focusNode: widget.focusNode,
              autofocus: true,
              maxLines: null,
              decoration: InputDecoration(
                hintText: '${l10n.writeAComment}...',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 9, bottom: 6),
              ),
              onChanged: (String text) {
                if (text.isNotEmpty) {
                  setState(() {
                    showSendButton = true;
                  });
                } else {
                  setState(() {
                    showSendButton = false;
                  });
                }
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          if (showSendButton)
            IconButton(
              onPressed: () {
                widget.onPostComment(
                  _contentController.text.trim(),
                );
                _contentController.text = '';
                setState(() {
                  showSendButton = false;
                });
              },
              icon: const Icon(Icons.send),
            )
//TEMP
        ],
      ),
    );
  }
}
