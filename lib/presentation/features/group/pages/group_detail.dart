import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/features/group/widget/create_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widget/post_item.dart';

class GroupDetail extends StatelessWidget {
  const GroupDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: const Color(0xffC4C4C4),
      appBar: AppBar(
        title: const Text('Language Exchange'),
      ),
      body: Column(
        children: [
          // Container(
          //   color: Colors.white,
          //   padding: EdgeInsets.all(16.sp),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text('Language exchange '),
          //       Row(
          //         children: const [
          //           Icon(Icons.people),
          //           Text('31'),
          //         ],
          //       ),
          //       const Text(
          //           'Discuss good topics to talk about, strategies for making the exchange more fun and rewarding and everything else related.'),
          //       Center(
          //         child: AppButtonWidget(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20.sp),
          //           ),
          //           onPressed: () {},
          //           label: Text(l10n.join),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          const CreatePostWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 5.sp),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                  child: const PostItem(
                    isPostDetail: false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   key: const Key('groupDetailFab'),
      //   onPressed: () => {},
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
