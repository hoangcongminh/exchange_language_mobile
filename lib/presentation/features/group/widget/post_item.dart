import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/avatar_widget.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.sp),
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarWidget(height: 30.sp, width: 30.sp),
              Column(
                children: const [
                  Text('James, Male, 20'),
                  Text('20-10-2021'),
                ],
              )
            ],
          ),
          const Text(
            'What to do on a tandem meetup',
          ),
          const Text(
              'Hi guys! I have been doing tandem language exchange quite a few times during the last years here in Berlin. While i do agree that this is a really good way to practise a language it can also be very hard to come up with good plans on how to organize the meetings. So i\'d like to ask do you have any favourite topics, games and just general tips for making exchange more fun and rewarding?'),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('18'),
              Text('4'),
            ],
          )
        ],
      ),
    );
  }
}
