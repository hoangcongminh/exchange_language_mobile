import 'dart:io';

import 'package:flutter/material.dart';

import 'custom_image_picker.dart';

class PickImageWidget extends StatefulWidget {
  final Function(File) onImagePicked;
  const PickImageWidget({Key? key, required this.onImagePicked})
      : super(key: key);

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
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
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
          : const SizedBox(
              width: 60,
              height: 60,
              child: Icon(
                Icons.image,
                size: 60,
                color: Colors.grey,
              ),
            ),
    );
  }
}
