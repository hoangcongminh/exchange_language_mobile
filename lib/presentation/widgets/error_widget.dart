import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onTapRefresh;
  const ErrorScreen({
    Key? key,
    required this.onTapRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(context.l10n.thereAreSomeError),
          TextButton(
            onPressed: onTapRefresh,
            child: Text(context.l10n.refresh),
          )
        ],
      ),
    );
  }
}
