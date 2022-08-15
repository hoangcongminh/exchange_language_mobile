import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/chat_style.dart';

class ConversationInput extends StatefulWidget {
  final Function(String content) onSend;
  final VoidCallback onTapImage;
  final VoidCallback onTapEmoji;
  final VoidCallback onTapRecord;
  const ConversationInput({
    Key? key,
    required this.onSend,
    required this.onTapImage,
    required this.onTapEmoji,
    required this.onTapRecord,
  }) : super(key: key);

  @override
  State<ConversationInput> createState() => _ConversationInputState();
}

class _ConversationInputState extends State<ConversationInput> {
  TextEditingController msgController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorConversationInput,
      child: Padding(
        padding: EdgeInsets.only(top: 8.sp, bottom: 16.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: IconButton(
                onPressed: widget.onTapImage,
                icon: const Icon(Icons.image),
              ),
            ),
             Flexible(
              flex: 1,
              child: IconButton(
                onPressed: widget.onTapRecord,
                icon: const Icon(Icons.mic),
              ),
            ),
            Flexible(
              flex: 4,
              child: TextFormField(
                focusNode: focusNode,
                controller: msgController,
                style: TextStyle(
                  color: colorTextChatCard,
                  fontSize: 12.sp,
                ),
                keyboardType: TextInputType.multiline,
                inputFormatters: const [
                  // MessageFormatter(),
                ],
                minLines: 1,
                maxLines: 2,
                onFieldSubmitted: (val) => {},
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: widget.onTapEmoji,
                      icon: const Icon(Icons.emoji_emotions_outlined)),
                  contentPadding: EdgeInsets.only(
                    left: 16.sp,
                    bottom: 3.sp,
                    top: 3.sp,
                    right: 10.sp,
                  ),
                  hintText: 'Typing...',
                  hintStyle: TextStyle(
                    color: colorTimeChat,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: colorBackgroundConversationInput,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (val) {},
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  widget.onSend(msgController.text);
                  msgController.clear();
                  focusNode.unfocus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
