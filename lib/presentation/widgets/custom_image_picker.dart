import 'dart:developer';

import 'package:exchange_language_mobile/presentation/widgets/dialog/dialog_loading.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CustomImagePicker {
  Future openImagePicker({
    required BuildContext context,
    String text = 'New Image',
    bool isRequireCrop = true,
    Function? handleFinish,
  }) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 210.sp,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.sp),
                topRight: Radius.circular(24.sp),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.sp,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 6.sp,
                ),
                CustomImagePickerItem(
                  index: 0,
                  icon: Icons.image,
                  text: 'Pick Image',
                  source: ImageSource.gallery,
                  handleFinish: handleFinish,
                ),
                Divider(
                  color: const Color(0xFFC5D0CF),
                  thickness: 0.3.sp,
                  height: 0.3.sp,
                ),
                CustomImagePickerItem(
                  index: 0,
                  icon: Icons.camera,
                  text: 'Take Image',
                  source: ImageSource.camera,
                  handleFinish: handleFinish,
                ),
                SizedBox(
                  height: 8.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomImagePickerItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String text;
  final ImageSource source;
  Function? handleFinish;
  CustomImagePickerItem({
    Key? key,
    required this.index,
    required this.icon,
    required this.text,
    required this.source,
    required this.handleFinish,
  }) : super(key: key);
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future getImage({context, source = ImageSource.gallery}) async {
      return await _picker.pickImage(source: source, imageQuality: 100);
    }

    return TextButton(
      onPressed: () async {
        try {
          AppNavigator().pop();
          XFile? image =
              await getImage(context: AppNavigator().context, source: source);
          showDialogLoading();
          if (image != null) {
            handleFinish?.call(image);
            AppNavigator().pop();
          }
        } catch (exception) {
          log(exception.toString());
        }
      },
      style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 0),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black.withOpacity(0.5);
              }
              return Colors.black; // Use the component's default.
            },
          ),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 12.sp),
            Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
