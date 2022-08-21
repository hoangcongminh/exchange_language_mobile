import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/blog_repository_impl.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../data/repositories/comment_repository_impl.dart';
import '../../data/repositories/filter_repository_impl.dart';
import '../../data/repositories/friend_repository_impl.dart';
import '../../data/repositories/group_repository_impl.dart';
import '../../data/repositories/language_repository_impl.dart';
import '../../data/repositories/media_repository_impl.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../features/authenticate/bloc/authenticate_bloc.dart';
import '../features/blog-detail/bloc/blog_detail_bloc.dart';
import '../features/blog/bloc/blog_bloc.dart';
import '../features/chat/bloc/chat_bloc.dart';
import '../features/chat/bloc/friend-list/friend_list_bloc.dart';
import '../features/comment/bloc/comment_bloc.dart';
import '../features/conversation/bloc/conversation_bloc.dart';
import '../features/create-blog/bloc/create_blog_bloc.dart';
import '../features/create-group/bloc/create_group_bloc.dart';
import '../features/create-post/bloc/create_post_bloc.dart';
import '../features/dashboard/bloc/dashboard_bloc.dart';
import '../features/filter/bloc/filter_bloc.dart';
import '../features/group-detail/bloc/group-detail-bloc/group_detail_bloc.dart';
import '../features/group-detail/bloc/post-bloc/post_bloc.dart';
import '../features/group/bloc/group_bloc.dart';
import '../features/update-profile-info/bloc/update_profile_info_bloc.dart';
import '../features/user-profile/bloc/friend-bloc/friend_bloc.dart';
import '../features/user-profile/bloc/user-profile-bloc/user_profile_bloc.dart';
import '../features/verification/bloc/verification_bloc.dart';
import 'application/application_bloc.dart';
import 'locale/cubit/locale_cubit.dart';

class AppBloc {
  static final localeCubit = LocaleCubit();
  static final authenticateBloc = AuthenticateBloc(
    AuthRepositoryImpl(),
    MediaRepositoryImpl(),
  );
  static final verificationBloc = VerificationBloc(AuthRepositoryImpl());
  static final applicationBloc = ApplicationBloc();
  static final dashboardBloc = DashboardBloc();
  static final userProfileBloc = UserProfileBloc(UserRepositoryImpl());
  static final friendBloc = FriendBloc(FriendRepositoryImpl());
  static final chatBloc = ChatBloc(ChatRepositoryImpl());
  static final friendListBloc = FriendListBloc(FriendRepositoryImpl());
  static final conversationBloc =
      ConversationBloc(ChatRepositoryImpl(), MediaRepositoryImpl());
  static final filterBloc = FilterBloc(
    LanguageRepositoryImpl(),
    FilterRepositoryImpl(),
  );
  static final groupBloc = GroupBloc(GroupRepositoryImpl());
  static final groupDetailBloc = GroupDetailBloc(GroupRepositoryImpl());
  static final createGroupBloc = CreateGroupBloc(
    GroupRepositoryImpl(),
    MediaRepositoryImpl(),
  );
  static final postBloc = PostBloc(PostRepositoryImpl());
  static final commentBloc = CommentBloc(CommentRepositoryImpl());

  static final createPostBloc = CreatePostBloc(PostRepositoryImpl());
  static final blogBloc = BlogBloc(BlogRepositoryImpl());
  static final createBlogBloc = CreateBlogBloc(
    BlogRepositoryImpl(),
    MediaRepositoryImpl(),
  );
  static final blogDetailBloc = BlogDetailBloc(BlogRepositoryImpl());
  static final updateProfileInfoBloc = UpdateProfileInfoBloc(
    UserRepositoryImpl(),
    MediaRepositoryImpl(),
  );

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<LocaleCubit>(
      create: (context) => localeCubit,
    ),
    BlocProvider<AuthenticateBloc>(
      create: (context) => authenticateBloc,
    ),
    BlocProvider<VerificationBloc>(
      create: (context) => verificationBloc,
    ),
    BlocProvider<DashboardBloc>(
      create: (context) => dashboardBloc,
    ),
    BlocProvider<UserProfileBloc>(
      create: (context) => userProfileBloc,
    ),
    BlocProvider<FriendBloc>(
      create: (context) => friendBloc,
    ),
    BlocProvider<ChatBloc>(
      create: (context) => chatBloc,
    ),
    BlocProvider<FriendListBloc>(
      create: (context) => friendListBloc,
    ),
    BlocProvider<FilterBloc>(
      create: (context) => filterBloc,
    ),
    BlocProvider<ConversationBloc>(
      create: (context) => conversationBloc,
    ),
    BlocProvider<GroupBloc>(
      create: (context) => groupBloc,
    ),
    BlocProvider<GroupDetailBloc>(
      create: (context) => groupDetailBloc,
    ),
    BlocProvider<CreateGroupBloc>(
      create: (context) => createGroupBloc,
    ),
    BlocProvider<PostBloc>(
      create: (context) => postBloc,
    ),
    BlocProvider<CreatePostBloc>(
      create: (context) => createPostBloc,
    ),
    BlocProvider<CommentBloc>(
      create: (context) => commentBloc,
    ),
    BlocProvider<BlogBloc>(
      create: (context) => blogBloc,
    ),
    BlocProvider<CreateBlogBloc>(
      create: (context) => createBlogBloc,
    ),
    BlocProvider<BlogDetailBloc>(
      create: (context) => blogDetailBloc,
    ),
    BlocProvider<UpdateProfileInfoBloc>(
      create: (context) => updateProfileInfoBloc,
    ),
  ];

  static void initialHomeBloc() {
    authenticateBloc.add(RefreshTokenEvent());
    chatBloc.add(FetchConversations());
    blogBloc.add(RefreshBlogsEvent());
    groupBloc.add(RefreshGroupsEvent());
    friendListBloc.add(FetchFriendList());
  }

  static void cleanBloc() {
    dashboardBloc.add(const OnChangeIndexEvent(index: 0));
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
