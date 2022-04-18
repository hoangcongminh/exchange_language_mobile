import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CustomImagePicker {
  final _picker = ImagePicker();

  Future getImage({context, source = ImageSource.gallery}) async {
    return await _picker.pickImage(source: source, imageQuality: 100);
  }

  Future openImagePicker(
      {required BuildContext context,
      String text = 'New image',
      bool isRequireCrop = true,
      Function? handleFinish}) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 30.h,
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
                CustomImagePickerItem(),
                CustomImagePickerItem(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomImagePickerItem extends StatelessWidget {
  const CustomImagePickerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
          animationDuration: Duration(milliseconds: 0),
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
            Icon(Icons.image),
            SizedBox(width: 12.sp),
            Text(
              'Add image',
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
