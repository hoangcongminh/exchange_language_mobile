import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/loading_widget.dart';
import '../bloc/group_bloc.dart';
import '../widget/group_item.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final group = state.groups[index];
                        return GestureDetector(
                          onTap: () =>
                              AppNavigator().push(RouteConstants.groupDetail),
                          child: GroupItem(
                            groupName: group.title,
                            author: group.author,
                            thumbnail: group.thumbnail,
                            description: group.description,
                            memberCount: group.members.length,
                          ),
                        );
                      },
                      itemCount: state.groups.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
