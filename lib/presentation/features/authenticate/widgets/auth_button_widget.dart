import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const AuthButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
