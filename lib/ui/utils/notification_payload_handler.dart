

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/app/like_grid_instance_manager.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/app/notification_payload_handler.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/main/notification_payload_handler.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui/normal/likes.dart';
import 'package:pihka_frontend/ui/normal/settings/media/current_moderation_request.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/utils/result.dart';

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
          bloc.add(
            HandleFirstPayload(createHandlePayloadCallback(context, bloc.accountBackgroundDb, showError: true)),
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
  {
    required bool showError,
    void Function(NavigatorStateBloc, NewPageDetails?) navigateToAction = defaultNavigateToAction,
  }) {
  final navigatorStateBloc = context.read<NavigatorStateBloc>();
  final bottomNavigatorStateBloc = context.read<BottomNavigationStateBloc>();
  final likeGridInstanceBloc = context.read<LikeGridInstanceManagerBloc>();

  return (payload) async {
    final newPage = await handlePayload(
      payload,
      navigatorStateBloc,
      bottomNavigatorStateBloc,
      likeGridInstanceBloc,
      accountBackgroundDb,
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
  {
    required bool showError,
  }
) async {
  final notificationSessionId = await BackgroundDatabaseManager.getInstance().commonStreamSingle(
    (db) => db.watchNotificationSessionId(),
  );
  if (notificationSessionId?.id != payload.sessionId.id) {
    log.warning("Notification payload session ID does not match current session ID");
    if (showError) {
      showSnackBar(R.strings.notification_session_expired_error);
    }
    return null;
  }

  switch (payload) {
    case NavigateToConversation():
      final dbId = NotificationIdStatic.revertNewMessageNotificationIdCalcualtion(payload.notificationId);
      final accountId = await accountBackgroundDb.accountData((db) => db.daoNewMessageNotification.getAccountId(dbId)).ok();
      if (accountId == null) {
        return null;
      }

      final profile = await DatabaseManager.getInstance().profileData((db) => db.getProfileEntry(accountId)).ok();
      if (profile == null) {
        return null;
      }

      final lastPage = NavigationStateBlocInstance.getInstance().bloc.state.pages.lastOrNull;
      final info = lastPage?.pageInfo;
      final correctConversatinoAlreadyOpen = info is ConversationPageInfo &&
        info.accountId == profile.uuid;
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
    case NavigateToModerationRequestStatus():
      return NewPageDetails(
        const MaterialPage<void>(
          child: CurrentModerationRequestScreenOpener(),
        ),
      );
  }
  return null;
}

// TODO: Thinking about the server side iterator for likes:
//
// If there is no reset iterator command in server API,
// then the next page API should have the iterator
// origin point as a parameter? Perhaps AccountId could be used for that?
// Actually that is not possible as for example that specific AccountId can be
// removed from likes. Perhaps use timestamp instead? Then the likeing time
// is exposed from API. Autoincrementing like ID perhaps could be used if
// those are unique.

// TODO: Notification settings. On Android 8 or later system notification
// settings should be opened.
