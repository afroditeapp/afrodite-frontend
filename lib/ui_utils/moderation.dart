

import 'package:flutter/widgets.dart';
import 'package:app/localizations.dart';

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
