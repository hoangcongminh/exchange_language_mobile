import 'package:exchange_language_mobile/common/helpers/utils/string_extension.dart';
import 'package:exchange_language_mobile/presentation/widgets/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/media.dart';

class BlogItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Media? thumbnail;
  final String createdAt;
  const BlogItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.thumbnail,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 8.sp),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            AppImageWidget(
                height: 100,
                width: 100,
                imageUrl: thumbnail == null
                    ? null
                    : '${AppConstants.baseImageUrl}${thumbnail!.src}'),
            SizedBox(width: 10.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  SizedBox(height: 8.sp),
                  Text(createdAt.formatTime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
