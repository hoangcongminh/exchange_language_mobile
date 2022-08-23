import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/features/notification/widgets/notification_shimmer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/app_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../widgets/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() {
    AppBloc.notificationBloc.add(FetchNotificaton());
    _refreshController.resetNoData();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notification),
      ),
      // body: const NotificationShimmerList(),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded) {
            return SmartRefresher(
              header: const WaterDropHeader(),
              onRefresh: _onRefresh,
              controller: _refreshController,
              // onLoading: _onLoading,
              // enablePullUp: true,
              child: ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AppBloc.notificationBloc.add(SeenNotification(
                          notificationId: state.notifications[index].id));
                    },
                    child: NotificationItem(
                      onDelete: () {
                        AppBloc.notificationBloc.add(DeleteNotification(
                            notificationId: state.notifications[index].id));
                      },
                      notification: state.notifications[index],
                    ),
                  );
                },
              ),
            );
          } else {
            return const NotificationShimmerList();
          }
        },
      ),
    );
  }
}
