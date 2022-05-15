import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/chat_style.dart';

class ConversationInput extends StatefulWidget {
  const ConversationInput({Key? key}) : super(key: key);

  @override
  State<ConversationInput> createState() => _ConversationInputState();
}

class _ConversationInputState extends State<ConversationInput> {
  TextEditingController msgController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
      child: Row(
        children: <Widget>[
          SizedBox(width: 12.sp),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
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
                    fillColor: colorBackgroundSender,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
          SizedBox(width: 10.sp),
        ],
      ),
    );
  }
}
