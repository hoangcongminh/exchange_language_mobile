import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextTap extends StatelessWidget {
  static final StreamController<List<int>> _streamSelectSub =
      StreamController<List<int>>.broadcast();
  static late List<int> _list;

  String text;
  TextStyle? textStyle;
  TextStyle? textStyleSelect;
  final Function(String text) selectText;
  EdgeInsets? paddingText;
  TextAlign? alignment;

  TextTap({
    Key? key,
    required this.text,
    this.textStyle,
    this.textStyleSelect,
    required this.selectText,
    this.paddingText,
    this.alignment = TextAlign.start,
  }) : super(key: key);

  void dispose() {
    _streamSelectSub.close();
  }

  static void clear() {
    _list.clear();
  }

  @override
  Widget build(BuildContext context) {
    _list = [];
    textStyleSelect ??= textStyle;

    // text = text.replaceAll('\n', '');
    if (text.length > 1 &&
        (text[text.length - 1] == ' ' ||
            text[text.length - 1] == '\n' ||
            text[text.length - 1] == '\b' ||
            text[text.length - 1] == '\t' ||
            text[text.length - 1] == '\r')) {
      text = text.substring(0, text.length - 1);
    }

    //add space before emoji
    final emojiRegExp = RegExp(
        r'\s(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    text = text.replaceAllMapped(emojiRegExp, (match) => '${match.group(1)}');

    final emojiRegExp1 = RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    text = text.replaceAllMapped(emojiRegExp1, (match) => ' ${match.group(1)}');
    //

    //
    text = text.replaceAll('\n', 'nnn ');

    final List<String> lstText =
        text.split(' ').map((String text) => text).toList();

    return StreamBuilder<List<int>>(
      stream: _streamSelectSub.stream,
      builder: (context, snapshot) {
        final List<TextSpan> listText = [];
        for (int i = 0; i < lstText.length; i++) {
          final hash = hashValues(text, i, key.hashCode);
          String textIndex = lstText[i];
          if (textIndex.contains('nnn')) {
            textIndex = textIndex.replaceAll('nnn', '');
            listText.addAll([
              TextSpan(
                text: textIndex,
                style: _list.contains(hash) ? textStyleSelect : textStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (_list.contains(hash) == false) {
                      _list.add(hash);
                    }
                    if (_list.isNotEmpty) {
                      _streamSelectSub.sink.add(_list);
                    }

                    selectText(textIndex);
                  },
              ),
              TextSpan(text: '\n')
            ]);
          } else {
            listText.addAll([
              TextSpan(
                text: textIndex,
                style: _list.contains(hash) ? textStyleSelect : textStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (_list.contains(hash) == false) {
                      _list.add(hash);
                    }
                    if (_list.isNotEmpty) {
                      _streamSelectSub.sink.add(_list);
                    }

                    selectText(textIndex);
                  },
              ),
              TextSpan(text: ' ')
            ]);
          }
        }

        return SelectableText.rich(
          TextSpan(
            children: listText,
          ),
          textAlign: alignment,
        );
      },
    );
  }
}
