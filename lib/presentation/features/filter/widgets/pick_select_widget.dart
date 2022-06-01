import 'package:exchange_language_mobile/domain/entities/language.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PickSelectWidget extends StatefulWidget {
  final String title;
  final List<Language> selectedLanguages;
  final Function() onTap;
  const PickSelectWidget(
      {Key? key,
      required this.title,
      required this.selectedLanguages,
      required this.onTap})
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
        width: double.infinity,
        height: 35.sp,
        margin: EdgeInsets.symmetric(vertical: 8.sp),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: widget.selectedLanguages.isEmpty
              ? Align(
                  alignment: Alignment.centerLeft, child: Text(widget.title))
              : SizedBox.expand(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: widget.selectedLanguages.length,
                    itemBuilder: (context, index) {
                      return SelectedLanguageItem(
                          language: widget.selectedLanguages[index].name);
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

class SelectedLanguageItem extends StatelessWidget {
  final String language;
  const SelectedLanguageItem({Key? key, required this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.sp),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Text(
          language,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
