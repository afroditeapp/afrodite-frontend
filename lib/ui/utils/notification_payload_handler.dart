

import 'dart:async';

import 'package:app/ui/normal/settings/admin/moderator_tasks.dart';
import 'package:app/ui/normal/settings/my_profile.dart';
import 'package:app/ui/normal/settings/news/news_list.dart';
import 'package:app/ui/normal/settings/notifications/automatic_profile_search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/app/like_grid_instance_manager.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/app/notification_payload_handler.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/main/notification_payload_handler.dart';
import 'package:app/ui/normal/chat/conversation_page.dart';
import 'package:app/ui/normal/likes.dart';
import 'package:app/ui/normal/settings/media/content_management.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

final log = Logger("NotificationPayloadHandler");

class NotificationPayloadHandler extends StatefulWidget {
  const NotificationPayloadHandler({super.key});

  @override
  State<NotificationPayloadHandler> createState() => _NotificationPayloadHandlerState();
}

class _NotificationPayloadHandlerState extends State<NotificationPayloadHandler> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationPayloadHandlerBloc, NotificationPayloadHandlerData>(
      buildWhen: (previous, current) => previous.toBeHandled != current.toBeHandled,
      builder: (context, state) {
        final payload = state.toBeHandled.firstOrNull;
        if (payload != null) {
          final bloc = context.read<NotificationPayloadHandlerBloc>();
          final navigatorStateBloc = context.read<NavigatorStateBloc>();
          final bottomNavigationStateBloc = context.read<BottomNavigationStateBloc>();
          final likeGridInstanceBloc = context.read<LikeGridInstanceManagerBloc>();
          bloc.add(
            HandleFirstPayload(createHandlePayloadCallback(
              context,
              bloc.accountBackgroundDb,
              bloc.accountDb,
              navigatorStateBloc,
              bottomNavigationStateBloc,
              likeGridInstanceBloc,
              showError: true)),
          );
        }

        return const SizedBox.shrink();
      }
    );
  }
}

Future<void> Function(NotificationPayload) createHandlePayloadCallback(
  BuildContext context,
  AccountBackgroundDatabaseManager accountBackgroundDb,
  AccountDatabaseManager accountDb,
  NavigatorStateBloc navigatorStateBloc,
  BottomNavigationStateBloc bottomNavigatorStateBloc,
  LikeGridInstanceManagerBloc likeGridInstanceBloc,
  {
    required bool showError,
    void Function(NavigatorStateBloc, NewPageDetails?) navigateToAction = defaultNavigateToAction,
  }) {

  return (payload) async {
    final newPage = await handlePayload(
      payload,
      navigatorStateBloc,
      bottomNavigatorStateBloc,
      likeGridInstanceBloc,
      accountBackgroundDb,
      accountDb,
      showError: showError,
    );
    navigateToAction(navigatorStateBloc, newPage);
  };
}

void defaultNavigateToAction(NavigatorStateBloc bloc, NewPageDetails? newPage) {
  if (newPage == null) {
    return;
  }
  bloc.pushWithKey(newPage.page, newPage.pageKey ?? PageKey(), pageInfo: newPage.pageInfo);
}

Future<NewPageDetails?> handlePayload(
  NotificationPayload payload,
  NavigatorStateBloc navigatorStateBloc,
  BottomNavigationStateBloc bottomNavigationStateBloc,
  LikeGridInstanceManagerBloc likeGridInstanceManagerBloc,
  AccountBackgroundDatabaseManager accountBackgroundDb,
  AccountDatabaseManager accountDb,
  {
    required bool showError,
  }
) async {
  final currentAccountId = await BackgroundDatabaseManager.getInstance().commonStreamSingle(
    (db) => db.loginSession.watchAccountId(),
  );
  if (currentAccountId == null || currentAccountId != payload.receiverAccountId) {
    log.warning("Notification payload receiver account ID does not match current session account ID");
    if (showError) {
      showSnackBar(R.strings.notification_action_ignored);
    }
    return null;
  }

  switch (payload) {
    case NavigateToConversation():
      final accountId = await accountBackgroundDb.accountData((db) => db.notification.convertConversationIdToAccountId(payload.conversationId)).ok();
      if (accountId == null) {
        return null;
      }

      final profile = await accountDb.accountData((db) => db.profile.getProfileEntry(accountId)).ok();
      if (profile == null) {
        return null;
      }

      final lastPage = NavigationStateBlocInstance.getInstance().navigationState.pages.lastOrNull;
      final info = lastPage?.pageInfo;
      final correctConversatinoAlreadyOpen = info is ConversationPageInfo &&
        info.accountId == profile.accountId;
      if (!correctConversatinoAlreadyOpen) {
        return newConversationPage(
          profile,
        );
      }
    case NavigateToConversationList():
      if (navigatorStateBloc.state.pages.length == 1) {
        bottomNavigationStateBloc.add(ChangeScreen(BottomNavigationScreenId.chats));
      } else {
        // This action only happens using push notifications so extra screen is
        // not needed.
      }
    case NavigateToLikes():
      if (navigatorStateBloc.state.pages.length == 1) {
        bottomNavigationStateBloc.add(ChangeScreen(BottomNavigationScreenId.likes));
      } else {
        return newLikesScreen(likeGridInstanceManagerBloc);
      }
    case NavigateToNews():
      return NewPageDetails(
        const MaterialPage<void>(
          child: NewsListScreenOpener(),
        ),
      );
    case NavigateToContentManagement():
      final currentPageInfo = NavigationStateBlocInstance.getInstance().navigationState.pages.lastOrNull?.pageInfo;
      if (currentPageInfo is! ContentManagementPageInfo) {
        return newContentManagementScreen();
      }
    case NavigateToMyProfile():
      final currentPageInfo = NavigationStateBlocInstance.getInstance().navigationState.pages.lastOrNull?.pageInfo;
      if (currentPageInfo is! MyProfilePageInfo) {
        return newMyProfileScreen();
      }
    case NavigateToAutomaticProfileSearchResults():
      final currentPageInfo = NavigationStateBlocInstance.getInstance().navigationState.pages.lastOrNull?.pageInfo;
      if (currentPageInfo is! AutomaticProfileSearchResultsPageInfo) {
        return newAutomaticProfileSearchResultsScreen();
      }
    case NavigateToModeratorTasks():
      return newModeratorTasksScreen();
  }
  return null;
}
