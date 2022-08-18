import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';

import '../../routes/app_pages.dart';

class TranslationDialog extends StatelessWidget {
  final Translation data;
  const TranslationDialog({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CupertinoAlertDialog(
      title: Text(l10n.translation),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.sourceLanguage.name),
          Text(data.source),
          Text(data.targetLanguage.name),
          Text(data.text),
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
  }
}
