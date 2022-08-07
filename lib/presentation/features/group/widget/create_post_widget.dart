import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/avatar_widget.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
        child: Row(
          children: [
            AvatarWidget(
              height: 40,
              width: 40,
              imageUrl:
                  '${AppConstants.baseImageUrl}${UserLocal().getUser()?.avatar.src}',
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            leading: IconButton(
                                onPressed: () => AppNavigator().pop(),
                                icon: const Icon(Icons.close)),
                            title: const Text('Create post'),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16.0, top: 8, bottom: 8),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Post'),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Create new post',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
