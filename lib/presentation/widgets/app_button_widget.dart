import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final Widget label;
  final VoidCallback onPressed;
  final double? width;
  final Color? color;
  final OutlinedBorder? shape;
  const AppButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
    this.color,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        shape: shape,
      ),
      onPressed: onPressed,
      child: label,
    );
  }
}
