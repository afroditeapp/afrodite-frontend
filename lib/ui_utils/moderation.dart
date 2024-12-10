

import 'package:flutter/widgets.dart';
import 'package:app/localizations.dart';

String addRejectedCategoryRow(BuildContext context, String input, int? category) {
  if (category != null) {
    return "$input\n\n${context.strings.moderation_rejected_category(category.toString())}";
  } else {
    return input;
  }
}

String addRejectedDeteailsRow(BuildContext context, String input, String? details) {
  if (details != null) {
    return "$input\n\n${context.strings.moderation_rejected_details(details)}";
  } else {
    return input;
  }
}
