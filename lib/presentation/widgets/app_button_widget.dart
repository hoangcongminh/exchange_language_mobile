import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final OutlinedBorder? shape;
  const AppButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shape: shape,
      ),
      child: Text(label),
      onPressed: onPressed,
    );
  }
}
