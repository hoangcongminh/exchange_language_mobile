import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../common/helpers/debouncer.dart';
import '../theme/chat_style.dart';

class SearchBox extends StatefulWidget {
  final Function(String text) onChanged;
  const SearchBox({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

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
        onChanged: (text) => _debouncer.run(() {
          widget.onChanged(text);
        }),
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
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.onChanged("");
                    _searchController.clear();
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
          prefixIcon: Container(
            margin: EdgeInsets.all(10.sp),
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
