import 'package:flutter/material.dart';

class TextfieldWidget extends StatefulWidget {
  final Color? boderColor;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final double? height;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const TextfieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.boderColor = Colors.grey,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.height,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocus = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        _isFocus = !_isFocus;
      });
    });
    super.initState();
  }

  OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: color, width: 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 16),
      focusNode: _focusNode,
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        focusedBorder: _inputBorder(Colors.blue),
        enabledBorder: _inputBorder(Colors.grey),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.all(12),
        errorBorder: _inputBorder(Colors.blue),
        focusedErrorBorder: _inputBorder(Colors.blue),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: _isFocus ? Colors.blue : Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}
