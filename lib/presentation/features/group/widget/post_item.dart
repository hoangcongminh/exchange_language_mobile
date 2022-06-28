import 'package:exchange_language_mobile/presentation/widgets/loading_widget.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:translator/translator.dart';

import '../../../theme/group_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/text_tap.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.sp),
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarWidget(
                height: 30.sp,
                width: 30.sp,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('James, Male, 20'),
                  Text('20-10-2021'),
                ],
              )
            ],
          ),
          Text(
            'What to do on a tandem meetup',
            style: postTitle,
          ),
          TextTap(
            text:
                'Hi guys! I have been doing tandem language exchange quite a few times during the last years here in Berlin. While i do agree that this is a really good way to practise a language it can also be very hard to come up with good plans on how to organize the meetings. So i\'d like to ask do you have any favourite topics, games and just general tips for making exchange more fun and rewarding?',
            textStyle: postContent,
            textStyleSelect: const TextStyle(
              color: Colors.red,
            ),
            selectText: (text) async {
              final translator = GoogleTranslator();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => FutureBuilder<Translation>(
                  future: translator.translate(text, to: 'vi'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const LoadingWidget();
                    }
                    return CupertinoAlertDialog(
                      title: const Text('Translation'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.sourceLanguage.name),
                          Text(snapshot.data!.source),
                          Text(snapshot.data!.targetLanguage.name),
                          Text(snapshot.data!.text),
                        ],
                      ),
                      actions: [
                        CupertinoDialogAction(
                            onPressed: () {
                              AppNavigator().pop();
                              TextTap.clear();
                            },
                            child: const Text('OK'))
                      ],
                    );
                  },
                ),
              );
            },
          ),
          Divider(thickness: 1.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {},
                label: const Text('18'),
                icon: const Icon(CupertinoIcons.heart),
              ),
              TextButton.icon(
                onPressed: () {},
                label: const Text('4'),
                icon: const Icon(Icons.comment),
              ),
            ],
          )
        ],
      ),
    );
  }
}
