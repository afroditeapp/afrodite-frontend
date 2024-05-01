

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/app/notification_payload_handler.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/model/freezed/logic/main/notification_payload_handler.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui/normal/settings/media/current_moderation_request.dart';
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
          sendPayloadHandlingCallback(context);
        }

        return const SizedBox.shrink();
      }
    );
  }

  void sendPayloadHandlingCallback(BuildContext context) {
    final navigatorStateBloc = context.read<NavigatorStateBloc>();
    final currentModerationRequestBloc = context.read<CurrentModerationRequestBloc>();
    final conversationBloc = context.read<ConversationBloc>();

    context.read<NotificationPayloadHandlerBloc>().add(
      HandleFirstPayload((payload) async {
        await handlePayload(
          payload,
          navigatorStateBloc,
          currentModerationRequestBloc,
          conversationBloc,
        );
      }),
    );
  }
}

Future<void> handlePayload(
  NotificationPayload payload,
  NavigatorStateBloc navigatorStateBloc,
  CurrentModerationRequestBloc currentModerationRequestBloc,
  ConversationBloc conversationBloc,
) async {
  final db = DatabaseManager.getInstance();

  final notificationSessionId = await db.commonStreamSingle((db) => db.watchNotificationSessionId());
  if (notificationSessionId?.id != payload.sessionId.id) {
    log.warning("Notification payload session ID does not match current session ID");
    return;
  }

  switch (payload) {
    case NavigateToConversation():
      final profile = await db.profileData((db) => db.getProfileEntryUsingLocalId(payload.profileLocalDbId)).ok();
      if (profile != null) {
        await openConversationScreenNoBuildContext(
          conversationBloc,
          navigatorStateBloc,
          profile,
        );
      }
    case NavigateToLikes():
      ();
    case NavigateToModerationRequestStatus():
      await navigatorStateBloc.push(
        MaterialPage<void>(
          child: CurrentModerationRequestScreen(
            currentModerationRequestBloc: currentModerationRequestBloc,
          ),
        ),
      );
  }
}
