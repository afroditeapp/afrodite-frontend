import 'dart:async';

import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:app/ui/normal.dart';
import 'package:app/ui/normal/settings/admin/moderator_tasks.dart';
import 'package:app/ui/normal/settings/my_profile.dart';
import 'package:app/ui/normal/settings/news/news_list.dart';
import 'package:app/ui/normal/settings/notifications/automatic_profile_search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/app/notification_payload_handler.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/main/notification_payload_handler.dart';
import 'package:app/ui/normal/chat/conversation_page.dart';
import 'package:app/ui/normal/likes.dart';
import 'package:app/ui/normal/settings/media/content_management.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import "package:app/logic/app/main_state_types.dart";

final _log = Logger("NotificationPayloadHandler");

class NotificationPayloadHandler extends StatefulWidget {
  const NotificationPayloadHandler({super.key});

  @override
  State<NotificationPayloadHandler> createState() => _NotificationPayloadHandlerState();
}

class _NotificationPayloadHandlerState extends State<NotificationPayloadHandler> {
  NotificationPayload? previous;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationPayloadHandlerBloc, NotificationPayloadHandlerData>(
      builder: (context, state) {
        final payload = state.toBeHandled.firstOrNull;
        if (payload != null && (previous == null || previous != payload)) {
          previous = payload;
          context.read<NotificationPayloadHandlerBloc>().add(HandleFirstPayload(payload));
          final r = context.read<RepositoryInstances>();
          final navigatorStateBloc = context.read<NavigatorStateBloc>();
          final bottomNavigationStateBloc = context.read<BottomNavigationStateBloc>();
          _handlePayloadRunningApp(payload, r, navigatorStateBloc, bottomNavigationStateBloc);
        }

        return const SizedBox.shrink();
      },
    );
  }
}

void _handlePayloadRunningApp(
  NotificationPayload payload,
  RepositoryInstances r,
  NavigatorStateBloc navigatorStateBloc,
  BottomNavigationStateBloc bottomNavigatorStateBloc,
) async {
  final action = await _handlePayload(payload, r, navigatorStateBloc.state, showError: true);

  switch (action) {
    case DoNothing():
      ();
    case NewScreen():
      await navigatorStateBloc.push(action.screen);
    case BottomNavigationChange():
      bottomNavigatorStateBloc.add(ChangeScreen(action.screen));
  }
}

Future<NotificationNavigationAction> _handlePayload(
  NotificationPayload payload,
  RepositoryInstances r,
  NavigatorStateData navigatorState, {
  required bool showError,
}) async {
  if (r.accountId != payload.receiverAccountId) {
    _log.warning(
      "Notification payload receiver account ID does not match current session account ID",
    );
    if (showError) {
      showSnackBar(R.strings.notification_action_ignored);
    }
    return DoNothing();
  }

  final lastPage = navigatorState.pages.lastOrNull;

  switch (payload) {
    case NavigateToConversation():
      final accountId = await r.accountBackgroundDb
          .accountData(
            (db) => db.notification.convertConversationIdToAccountId(payload.conversationId),
          )
          .ok();
      if (accountId == null) {
        return DoNothing();
      }

      final profile = await r.accountDb
          .accountData((db) => db.profile.getProfileEntry(accountId))
          .ok();
      if (profile == null) {
        return DoNothing();
      }

      if (lastPage is ConversationPage && lastPage.accountId == profile.accountId) {
        return DoNothing();
      } else {
        return NewScreen(ConversationPage(profile.accountId, profile));
      }
    case NavigateToConversationList():
      if (navigatorState.pages.length == 1) {
        return BottomNavigationChange(BottomNavigationScreenId.chats);
      } else {
        // This action is for fallback conversation notification so
        // it is not worth to implement a separate screen for conversations.
        return DoNothing();
      }
    case NavigateToLikes():
      if (navigatorState.pages.length == 1) {
        return BottomNavigationChange(BottomNavigationScreenId.likes);
      } else {
        return NewScreen(LikesPage());
      }
    case NavigateToNews():
      if (lastPage is NewsListPage) {
        return DoNothing();
      } else {
        return NewScreen(NewsListPage());
      }
    case NavigateToContentManagement():
      if (lastPage is ContentManagementPage) {
        return DoNothing();
      } else {
        return NewScreen(ContentManagementPage());
      }
    case NavigateToMyProfile():
      if (lastPage is MyProfilePage) {
        return DoNothing();
      } else {
        return NewScreen(MyProfilePage());
      }
    case NavigateToAutomaticProfileSearchResults():
      if (lastPage is AutomaticProfileSearchResultsPage) {
        return DoNothing();
      } else {
        return NewScreen(AutomaticProfileSearchResultsPage());
      }
    case NavigateToModeratorTasks():
      if (lastPage is ModeratorTasksPage) {
        return DoNothing();
      } else {
        return NewScreen(ModeratorTasksPage(r));
      }
  }
}

Future<AppLaunchNotification?> handleAppLaunchNotificationPayload(
  NotificationPayload payload,
  RepositoryInstances r,
) async {
  final rootScreen = NormalStatePage();
  final navigationState = NavigatorStateData.rootPage(rootScreen);

  final action = await _handlePayload(payload, r, navigationState, showError: false);

  switch (action) {
    case DoNothing():
      return null;
    case NewScreen():
      return AppLaunchNotification(
        NavigatorStateData.rootPageAndOtherPage(rootScreen, action.screen),
        BottomNavigationStateData(),
      );
    case BottomNavigationChange():
      return AppLaunchNotification(
        navigationState,
        BottomNavigationStateData(screen: action.screen),
      );
  }
}

sealed class NotificationNavigationAction {}

class DoNothing extends NotificationNavigationAction {}

class NewScreen extends NotificationNavigationAction {
  final MyScreenPage<Object> screen;
  NewScreen(this.screen);
}

class BottomNavigationChange extends NotificationNavigationAction {
  final BottomNavigationScreenId screen;
  BottomNavigationChange(this.screen);
}
