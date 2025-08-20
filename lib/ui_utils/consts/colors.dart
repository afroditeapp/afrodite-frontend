import 'package:flutter/material.dart';

const LINK_COLOR = Colors.blue;

// This color is from _IconButtonDefaultsM3
// which is in Flutter sources.
Color getIconButtonEnabledColor(BuildContext context) {
  return Theme.of(context).colorScheme.onSurfaceVariant;
}

// This color is from _IconButtonDefaultsM3
// which is in Flutter sources.
Color getIconButtonDisabledColor(BuildContext context) {
  return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38);
}

Color getUnlimitedLikesColor(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}
