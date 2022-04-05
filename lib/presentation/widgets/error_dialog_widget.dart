import 'package:flutter/cupertino.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    required this.errorTitle,
    required this.errorMessage,
  }) : super(key: key);

  final String errorTitle;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(errorTitle),
      content: Text(errorMessage),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
