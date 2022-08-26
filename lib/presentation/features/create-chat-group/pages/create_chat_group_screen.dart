import 'dart:io';

import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/features/chat/bloc/friend-list/friend_list_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/create-chat-group/bloc/create_chat_group_bloc.dart';
import 'package:exchange_language_mobile/presentation/theme/colors.dart';
import 'package:exchange_language_mobile/presentation/widgets/search_box.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../common/app_bloc.dart';
import '../../../theme/blog_style.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/pick_image_widget.dart';
import '../../chat/bloc/chat_bloc.dart';

class CreateChatGroupScreen extends StatefulWidget {
  const CreateChatGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateChatGroupScreen> createState() => _CreateChatGroupScreenState();
}

class _CreateChatGroupScreenState extends State<CreateChatGroupScreen> {
  File? _imagePicked;
  List<String> members = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createGroupChat),
        actions: [
          IconButton(
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                AppBloc.createChatGroupBloc.add(CreateGroupChat(
                  groupName: _nameController.text.trim(),
                  avatar: _imagePicked,
                  members: members,
                ));
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: BlocConsumer<CreateChatGroupBloc, CreateChatGroupState>(
        listener: (context, state) {
          if (state is CreateChatGroupFailure) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                errorTitle: l10n.createBlogError,
                errorMessage: state.message,
              ),
            );
          } else if (state is CreateChatGroupSuccess) {
            AppBloc.chatBloc.add(FetchConversations());
            AppNavigator().pop();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: SizedBox(
                  height: 50.sp,
                  child: Row(
                    children: [
                      PickImageWidget(
                        size: 80,
                        icon: Icons.image,
                        shape: BoxShape.circle,
                        onImagePicked: (file) {
                          setState(() {
                            _imagePicked = file;
                          });
                        },
                      ),
                      SizedBox(
                        width: 4.sp,
                      ),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            autofocus: true,
                            controller: _nameController,
                            style: createBlogTitle,
                            decoration: InputDecoration(
                              hintText: l10n.groupChatName,
                              hintStyle: createBlogTitleHint,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterSomeText;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.sp,
              ),
              SearchBox(onChanged: (text) {}),
              SizedBox(
                height: 8.sp,
              ),
              BlocBuilder<FriendListBloc, FriendListState>(
                builder: (context, state) {
                  if (state is FriendListLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.friends.length,
                        itemBuilder: (context, index) {
                          final friend = state.friends[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: AvatarWidget(
                                    shape: BoxShape.circle,
                                    height: 35.sp,
                                    width: 35.sp,
                                    imageUrl:
                                        '${AppConstants.baseImageUrl}${friend.avatar!.src}'),
                                title: Text(
                                  friend.fullname,
                                  style: TextStyle(
                                    color: members.contains(friend.id)
                                        ? Theme.of(context).primaryColor
                                        : null,
                                  ),
                                ),
                                trailing: Checkbox(
                                  activeColor: AppColors.primaryColor,
                                  value: members.contains(friend.id),
                                  onChanged: (value) {
                                    setState(() {
                                      if (members.contains(friend.id)) {
                                        members.remove(friend.id);
                                      } else {
                                        members.add(friend.id);
                                      }
                                    });
                                  },
                                  shape: const CircleBorder(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 50.sp),
                                child: Divider(thickness: 1.sp),
                              )
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}
