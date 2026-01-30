import 'package:flutter/material.dart';
import 'package:app/localizations.dart';
import 'package:openapi/api.dart';

String addModerationStateRow(BuildContext context, String input, String? state) {
  if (state != null) {
    return "$input\n\n${context.strings.moderation_state(state)}";
  } else {
    return input;
  }
}

String addRejectedCategoryRow(BuildContext context, String input, int? category) {
  if (category != null) {
    return "$input\n\n${context.strings.moderation_rejected_category(category.toString())}";
  } else {
    return input;
  }
}

String addRejectedDetailsRow(BuildContext context, String input, String? details) {
  if (details != null && details.isNotEmpty) {
    return "$input\n\n${context.strings.moderation_rejected_details(details)}";
  } else {
    return input;
  }
}

Widget rejectionDetailsText(
  BuildContext context, {
  int? category,
  String? details,
  String? preliminaryText,
  EdgeInsetsGeometry padding = const EdgeInsetsGeometry.all(0),
  required Color containerColor,
  required Color textColor,
}) {
  String infoText = preliminaryText ?? "";
  infoText = addRejectedCategoryRow(context, infoText, category);
  infoText = addRejectedDetailsRow(context, infoText, details);
  infoText = infoText.trim();

  if (infoText.isNotEmpty) {
    return Padding(
      padding: padding,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: containerColor, borderRadius: BorderRadius.circular(4.0)),
        child: Text(
          infoText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
        ),
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}

String getProfileNameRejectionInfoText(
  BuildContext context,
  ProfileStringModerationState? state,
  int? category,
  String? details, {
  bool includeBaseText = true,
}) {
  var infoText = includeBaseText
      ? context.strings.view_profile_screen_non_accepted_profile_name_info_dialog_text
      : '';
  final stateText = switch (state) {
    ProfileStringModerationState.rejectedByBot => context.strings.moderation_state_rejected_by_bot,
    ProfileStringModerationState.rejectedByHuman =>
      context.strings.moderation_state_rejected_by_human,
    ProfileStringModerationState.waitingBotOrHumanModeration =>
      context.strings.moderation_state_waiting_bot_or_human_moderation,
    ProfileStringModerationState.waitingHumanModeration =>
      context.strings.moderation_state_waiting_human_moderation,
    _ => null,
  };
  infoText = addModerationStateRow(context, infoText, stateText);
  infoText = addRejectedCategoryRow(context, infoText, category);
  infoText = addRejectedDetailsRow(context, infoText, details);
  return infoText.trim();
}

String getProfileTextRejectionInfoText(
  BuildContext context,
  ProfileStringModerationState? state,
  int? category,
  String? details, {
  bool includeBaseText = true,
}) {
  var infoText = includeBaseText
      ? context.strings.view_profile_screen_non_accepted_profile_text_info_dialog_text
      : '';
  final stateText = switch (state) {
    ProfileStringModerationState.rejectedByBot => context.strings.moderation_state_rejected_by_bot,
    ProfileStringModerationState.rejectedByHuman =>
      context.strings.moderation_state_rejected_by_human,
    ProfileStringModerationState.waitingBotOrHumanModeration =>
      context.strings.moderation_state_waiting_bot_or_human_moderation,
    ProfileStringModerationState.waitingHumanModeration =>
      context.strings.moderation_state_waiting_human_moderation,
    _ => null,
  };
  infoText = addModerationStateRow(context, infoText, stateText);
  infoText = addRejectedCategoryRow(context, infoText, category);
  infoText = addRejectedDetailsRow(context, infoText, details);
  return infoText.trim();
}

bool isRejectedState(ProfileStringModerationState? state) {
  return state == ProfileStringModerationState.rejectedByBot ||
      state == ProfileStringModerationState.rejectedByHuman;
}
