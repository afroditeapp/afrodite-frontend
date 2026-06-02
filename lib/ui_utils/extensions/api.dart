import 'package:app/ui/normal/settings/admin/report/process_reports.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';

extension ProfileStringModerationStateUiExtensions on ProfileStringModerationState {
  String? toUiString(BuildContext context) {
    return switch (this) {
      ProfileStringModerationState.waitingAdminBot =>
        context.strings.moderation_state_waiting_admin_bot,
      ProfileStringModerationState.waitingAdmin => context.strings.moderation_state_waiting_admin,
      ProfileStringModerationState.acceptedByAdminBot ||
      ProfileStringModerationState.acceptedByAdmin => context.strings.moderation_state_accepted,
      ProfileStringModerationState.rejectedByAdminBot =>
        context.strings.moderation_state_rejected_by_admin_bot,
      ProfileStringModerationState.rejectedByAdmin =>
        context.strings.moderation_state_rejected_by_admin,
      _ => null,
    };
  }
}

extension ContentModerationStateUiExtensions on ContentModerationState {
  String? toUiString(BuildContext context) {
    return switch (this) {
      ContentModerationState.inSlot => null,
      ContentModerationState.waitingAdminBot => context.strings.moderation_state_waiting_admin_bot,
      ContentModerationState.waitingAdmin => context.strings.moderation_state_waiting_admin,
      ContentModerationState.acceptedByAdminBot ||
      ContentModerationState.acceptedByAdmin => context.strings.moderation_state_accepted,
      ContentModerationState.rejectedByAdminBot =>
        context.strings.moderation_state_rejected_by_admin_bot,
      ContentModerationState.rejectedByAdmin => context.strings.moderation_state_rejected_by_admin,
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

extension AccountBanReasonCategoryUiExtensions on AccountBanReasonCategory {
  String toUiString(BuildContext context) {
    return switch (value) {
      0 => context.strings.account_ban_reason_category_profile_name,
      1 => context.strings.account_ban_reason_category_profile_text,
      2 => context.strings.account_ban_reason_category_image,
      3 => context.strings.account_ban_reason_category_chat_message,
      4 => context.strings.account_ban_reason_category_report_spam,
      _ => value.toString(),
    };
  }
}

extension StringResourceUiExtensions on StringResource {
  String toLocalizedText(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final translated = translations[languageCode];
    if (translated != null && translated.isNotEmpty) {
      return translated;
    } else {
      return default_;
    }
  }
}
