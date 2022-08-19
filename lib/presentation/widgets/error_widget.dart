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
          const Text('There are some error'),
          TextButton(
            onPressed: onTapRefresh,
            child: const Text('Refresh'),
          )
        ],
      ),
    );
  }
}
