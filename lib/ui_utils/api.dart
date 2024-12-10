

import 'package:flutter/widgets.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';

extension ContentModerationStateUiExtensions on ContentModerationState {
  String? toUiString(BuildContext context) {
      return switch (this) {
        ContentModerationState.inSlot => null,
        ContentModerationState.waitingBotOrHumanModeration => context.strings.moderation_state_waiting_bot_or_human_moderation,
        ContentModerationState.waitingHumanModeration => context.strings.moderation_state_waiting_human_moderation,
        ContentModerationState.acceptedByBot ||
        ContentModerationState.acceptedByHuman => context.strings.moderation_state_accepted,
        ContentModerationState.rejectedByBot => context.strings.moderation_state_rejected_by_bot,
        ContentModerationState.rejectedByHuman => context.strings.moderation_state_rejected_by_human,
        _ => null,
      };
  }
}
