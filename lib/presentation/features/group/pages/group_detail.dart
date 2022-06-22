import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/app_button_widget.dart';
import '../widget/post_item.dart';

class GroupDetail extends StatelessWidget {
  const GroupDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC4C4C4),
      appBar: AppBar(
        title: const Text('Language Exchange'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Language exchange '),
                        Row(
                          children: const [
                            Icon(Icons.people),
                            Text('31'),
                          ],
                        ),
                        const Text(
                            'Discuss good topics to talk about, strategies for making the exchange more fun and rewarding and everything else related.'),
                        Center(
                          child: AppButtonWidget(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            onPressed: () {},
                            label: 'Join',
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const PostItem();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
