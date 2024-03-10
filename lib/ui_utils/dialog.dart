import 'package:flutter/material.dart';
import 'package:pihka_frontend/assets.dart';
import 'package:pihka_frontend/localizations.dart';

void showAppAboutDialog(BuildContext context) {
  // TODO(prod): Finish about dialog information
  const double ICON_SIZE = 80.0;
  showAboutDialog(
    context: context,
    applicationName: context.strings.app_name,
    applicationVersion: "0.1.0",
    applicationIcon: Image.asset(
      ImageAsset.appLogo.path,
      width: ICON_SIZE,
      height: ICON_SIZE,
    ),
    applicationLegalese: "© 2024 Pihka",
  );
}

Future<bool?> showConfirmDialog(BuildContext context, String actionText, {String? details}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(actionText),
      content: details != null ? Text(details) : null,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(context.strings.generic_cancel)
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(context.strings.generic_ok)
        )
      ],
    )
  );
}

Future<bool?> showInfoDialog(BuildContext context, String text) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: SelectableText(text),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(context.strings.generic_close)
        ),
      ],
    )
  );
}
