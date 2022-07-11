import 'dart:io';

import 'package:flutter/material.dart';

import 'custom_image_picker.dart';

class PickImageWidget extends StatefulWidget {
  final Function(File) onImagePicked;
  final double size;
  final IconData icon;
  final BoxShape shape;
  const PickImageWidget({
    Key? key,
    required this.onImagePicked,
    required this.size,
    required this.icon,
    required this.shape,
  }) : super(key: key);

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  File? _imagePicked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomImagePicker().openImagePicker(
            context: context,
            handleFinish: (file) {
              widget.onImagePicked(file);
              setState(() {
                _imagePicked = file;
              });
            });
      },
      child: _imagePicked != null
          ? Stack(
              children: [
                Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: widget.shape,
                    image: _imagePicked == null
                        ? null
                        : DecorationImage(
                            image: FileImage(_imagePicked!),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            )
          : SizedBox(
              width: widget.size,
              height: widget.size,
              child: Icon(
                widget.icon,
                size: widget.size,
                color: Colors.grey,
              ),
            ),
    );
  }
}
