import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/assets.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/loading_dialog.dart';

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

Future<bool?> showConfirmDialog(BuildContext context, String titleText, {String? details}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(titleText),
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

Future<void> showConfirmDialogAdvanced(
  {
    required BuildContext context,
    required String title,
    String? details,
    void Function()? onSuccess,
  }
) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: details != null ? Text(details) : null,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text(context.strings.generic_cancel)
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
            if (onSuccess != null) {
              onSuccess();
            }
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

void showLoadingDialogWithAutoDismiss<B extends StateStreamable<S>, S>(
  BuildContext context,
  {
    required bool Function(S) dialogVisibilityGetter,
    required void Function() dismissAction,
  }
) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<B, S>(
                buildWhen: (previous, current) =>
                  dialogVisibilityGetter(previous) != dialogVisibilityGetter(current),
                builder: (context, state) {
                  if (!dialogVisibilityGetter(state)) {
                    Future.delayed(Duration.zero, () {
                      dismissAction();
                    });
                  }
                  return commonLoadingDialogIndicator();
                }
              ),
            ],
          ),
        ),
      );
    }
  );
}
