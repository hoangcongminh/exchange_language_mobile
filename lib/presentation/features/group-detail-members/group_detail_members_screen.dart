import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/common/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/group-detail-members/bloc/group_detail_members_bloc.dart';
import 'package:exchange_language_mobile/presentation/widgets/app_button_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/avatar_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../common/constants/app_constants.dart';

class GroupDetailMembers extends StatelessWidget {
  final String groupId;
  const GroupDetailMembers({Key? key, required this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.joinGroupRequests),
      ),
      body: BlocBuilder<GroupDetailMembersBloc, GroupDetailMembersState>(
        builder: (context, state) {
          if (state is GroupDetailMembersLoaded) {
            return ListView.builder(
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: true,
                  leading: AvatarWidget(
                    width: 50.sp,
                    height: 50.sp,
                    imageUrl: state.requests[index].avatar == null
                        ? null
                        : '${AppConstants.baseImageUrl}${state.requests[index].avatar!.src}',
                  ),
                  title: Text(state.requests[index].fullname),
                  subtitle: Row(children: [
                    AppButtonWidget(
                      label: Text(l10n.confirm),
                      onPressed: () => AppBloc.groupDetailMembersBloc
                          .add(AcceptJoinGroupRequest(
                        userId: state.requests[index].id,
                        groupId: groupId,
                      )),
                    ),
                    SizedBox(
                      width: 8.sp,
                    ),
                    AppButtonWidget(
                      label: Text(l10n.delete),
                      onPressed: () => AppBloc.groupDetailMembersBloc
                          .add(RejectJoinGroupRequest(
                        userId: state.requests[index].id,
                        groupId: groupId,
                      )),
                      color: Colors.grey,
                    )
                  ]),
                );
              },
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
