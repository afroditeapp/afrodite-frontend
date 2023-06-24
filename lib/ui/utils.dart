

import 'package:flutter/material.dart';
import 'package:pihka_frontend/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showSnackBar(String text) {
  globalScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  globalScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(text), behavior: SnackBarBehavior.floating)
  );
}

Future<bool?> showConfirmDialog(BuildContext context, String actionText) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(actionText),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(AppLocalizations.of(context).genericCancel)
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(AppLocalizations.of(context).genericOk)
        )
      ],
    )
  );
}