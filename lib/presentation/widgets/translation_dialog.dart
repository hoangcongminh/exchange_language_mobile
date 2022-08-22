import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/theme/colors.dart';
import 'package:exchange_language_mobile/presentation/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';

import '../../routes/app_pages.dart';

class TranslationDialog extends StatelessWidget {
  final Translation? data;
  const TranslationDialog({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CupertinoAlertDialog(
      title: Text(l10n.translation),
      content: data == null
          ? const Center(
              child: LoadingWidget(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data!.sourceLanguage.name,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(data!.source),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  data!.targetLanguage.name,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(data!.text),
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
