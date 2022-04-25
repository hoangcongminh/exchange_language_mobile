import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter/material.dart';

showDialogLoading() {
  showDialog(
    context: AppNavigator().context!,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ),
      );
    },
    barrierColor: const Color(0x80000000),
    barrierDismissible: false,
  );
}
