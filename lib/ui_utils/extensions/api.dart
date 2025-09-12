import 'package:app/ui/normal/settings/admin/report/process_reports.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';

extension ContentModerationStateUiExtensions on ContentModerationState {
  String? toUiString(BuildContext context) {
    return switch (this) {
      ContentModerationState.inSlot => null,
      ContentModerationState.waitingBotOrHumanModeration =>
        context.strings.moderation_state_waiting_bot_or_human_moderation,
      ContentModerationState.waitingHumanModeration =>
        context.strings.moderation_state_waiting_human_moderation,
      ContentModerationState.acceptedByBot ||
      ContentModerationState.acceptedByHuman => context.strings.moderation_state_accepted,
      ContentModerationState.rejectedByBot => context.strings.moderation_state_rejected_by_bot,
      ContentModerationState.rejectedByHuman => context.strings.moderation_state_rejected_by_human,
      _ => null,
    };
  }
}

extension CustomReportUiExtensions on CustomReport {
  String translatedName(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final languages = translations
        .where((element) => element.lang == locale.languageCode)
        .firstOrNull;
    if (languages == null) {
      return name;
    }

    for (final t in languages.values) {
      if (t.key == key) {
        return t.name;
      }
    }

    return name;
  }
}

extension ClientVersionUiExtensions on ClientVersion {
  String versionString() {
    return "$major.$minor.$patch_";
  }
}

extension ReportExtensions on ReportDetailed {
  WrappedReportDetailed toWrapped() {
    return WrappedReportDetailed(
      info: info,
      content: content,
      creatorInfo: creatorInfo,
      targetInfo: targetInfo,
      chatInfo: chatInfo,
    );
  }
}

extension ProfileStringModerationContentTypeExtensions on ProfileStringModerationContentType {
  String adminUiText() {
    switch (this) {
      case ProfileStringModerationContentType.profileName:
        return "profile name";
      case ProfileStringModerationContentType.profileText:
        return "profile text";
      case ProfileStringModerationContentType():
        return "error";
    }
  }

  String adminUiTextPlular() {
    switch (this) {
      case ProfileStringModerationContentType.profileName:
        return "profile names";
      case ProfileStringModerationContentType.profileText:
        return "profile texts";
      case ProfileStringModerationContentType():
        return "error";
    }
  }

  String adminUiTextFirstLetterUppercase() {
    return toBeginningOfSentenceCase(adminUiText());
  }
}

extension AccountIdUiExtensions on AccountId {
  String shortAccountIdString() {
    return aid.substring(0, 5);
  }
}
