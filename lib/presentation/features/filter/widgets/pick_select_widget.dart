import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PickSelectWidget extends StatefulWidget {
  final String title;
  final Function() onTap;
  const PickSelectWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  State<PickSelectWidget> createState() => _PickSelectWidgetState();
}

class _PickSelectWidgetState extends State<PickSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.sp),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Text(widget.title),
        ),
      ),
    );
  }
}
