import 'package:exchange_language_mobile/presentation/common/locale/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../presentation/widgets/translation_dialog.dart';

class TranslationHelper {
  void showTranslate(BuildContext context, text) {
    final translator = GoogleTranslator();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => FutureBuilder<Translation>(
        future: translator.translate(text,
            to: LocaleCubit.getLocale().languageCode),
        builder: (context, snapshot) {
          return TranslationDialog(data: snapshot.data);
        },
      ),
    );
  }
}
