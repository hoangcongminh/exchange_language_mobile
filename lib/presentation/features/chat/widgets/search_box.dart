import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/chat_style.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.sp,
      width: 100.w,
      margin: EdgeInsets.symmetric(horizontal: 16.sp),
      decoration: BoxDecoration(
        color: colorBackgroundSearch,
        borderRadius: BorderRadius.circular(50.sp),
      ),
      child: TextFormField(
        controller: _searchController,
        maxLines: 1,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 0.sp,
            right: 10.sp,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: colorCaptionSearch,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(10.sp),
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
