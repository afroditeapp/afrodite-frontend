import 'package:app/config.dart';
import 'package:app/data/app_version.dart';
import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/ui_utils/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/assets.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/loading_dialog.dart';

void showAppAboutDialog(BuildContext context, ClientFeaturesConfigData? config) {
  const double ICON_SIZE = 80.0;

  final publisher = context.strings.app_publisher;
  final commitId = GIT_COMMIT_ID;
  final attributionText = config?.aboutDialogAttribution(context);

  // About dialog uses root navigator as there is navigation related to
  // viewing licenses.
  showDialog<void>(
    context: context,
    builder: (context) => AboutDialog(
      applicationName: context.strings.app_name,
      applicationVersion: AppVersionManager.getInstance().appVersion,
      applicationIcon: Image.asset(
        ImageAsset.appLogo.path,
        width: ICON_SIZE,
        height: ICON_SIZE,
        cacheHeight: calculateCachedImageSize(context, ICON_SIZE),
      ),
      applicationLegalese: R.strings.app_legalese,
      children: [
        if (publisher.isNotEmpty) Padding(padding: EdgeInsetsGeometry.only(top: 8)),
        if (publisher.isNotEmpty)
          SelectableText(context.strings.about_dialog_app_publisher(publisher)),
        if (commitId != null) Padding(padding: EdgeInsetsGeometry.only(top: 8)),
        if (commitId != null) SelectableText(R.strings.about_dialog_git_commit_id(commitId)),
        if (attributionText != null) Padding(padding: EdgeInsetsGeometry.only(top: 8)),
        if (attributionText != null) SelectableText(attributionText),
      ],
    ),
  );
}

class ConfirmDialogPage extends MyDialogPage<bool> {
  ConfirmDialogPage({required super.builder});
}

Future<bool?> showConfirmDialog(
  BuildContext context,
  String titleText, {
  String? details,
  bool yesNoActions = false,
  bool scrollable = false,
}) {
  return MyNavigator.showDialog<bool>(
    context: context,
    page: ConfirmDialogPage(
      builder: (context, closer) {
        final String negativeActionText;
        final String positiveActionText;
        if (yesNoActions) {
          negativeActionText = context.strings.generic_no;
          positiveActionText = context.strings.generic_yes;
        } else {
          negativeActionText = context.strings.generic_cancel;
          positiveActionText = context.strings.generic_ok;
        }

        return AlertDialog(
          title: Text(titleText),
          content: details != null ? Text(details) : null,
          scrollable: scrollable,
          actions: <Widget>[
            TextButton(
              onPressed: () => closer.close(context, false),
              child: Text(negativeActionText),
            ),
            TextButton(
              onPressed: () => closer.close(context, true),
              child: Text(positiveActionText),
            ),
          ],
        );
      },
    ),
  );
}

class ConfirmDialogAdvancedPage extends MyDialogPage<()> {
  ConfirmDialogAdvancedPage({required super.builder});
}

Future<void> showConfirmDialogAdvanced({
  required BuildContext context,
  required String title,
  String? details,
  void Function()? onSuccess,
}) {
  return MyNavigator.showDialog<()>(
    context: context,
    page: ConfirmDialogAdvancedPage(
      builder: (context, closer) {
        return AlertDialog(
          title: Text(title),
          content: details != null ? Text(details) : null,
          actions: <Widget>[
            TextButton(
              onPressed: () => closer.close(context, ()),
              child: Text(context.strings.generic_cancel),
            ),
            TextButton(
              onPressed: () {
                closer.close(context, ());
                if (onSuccess != null) {
                  onSuccess();
                }
              },
              child: Text(context.strings.generic_ok),
            ),
          ],
        );
      },
    ),
  );
}

class InfoDialogPage extends MyDialogPage<()> {
  InfoDialogPage({required super.builder});
}

Future<()?> showInfoDialog(
  BuildContext context,
  String text, {
  PageKey? existingPageToBeRemoved,
  bool scrollable = false,
}) {
  Widget dialogBuilder(BuildContext context, PageCloser<()> closer) => AlertDialog(
    content: SelectableText(text),
    actions: <Widget>[
      TextButton(
        onPressed: () => closer.close(context, ()),
        child: Text(context.strings.generic_close),
      ),
    ],
    scrollable: scrollable,
  );

  final page = InfoDialogPage(builder: dialogBuilder);

  if (existingPageToBeRemoved == null) {
    return MyNavigator.showDialog<()>(context: context, page: page);
  } else {
    return MyNavigator.removeAndShowDialog<()>(
      context: context,
      toBeRemoved: existingPageToBeRemoved,
      page: page,
    );
  }
}

class LoadingDialogPage extends MyDialogPage<()> {
  LoadingDialogPage({required super.builder}) : super(barrierDismissable: false);
}

/// When dismiss action runs the dialog is already dismissed.
Future<()?> showLoadingDialogWithAutoDismiss<B extends StateStreamable<S>, S>(
  BuildContext context, {
  required bool Function(S) dialogVisibilityGetter,
  required PageKey removeAlsoThisPage,
}) async {
  final page = LoadingDialogPage(
    builder: (context, closer) {
      return _loadingDialogContent<B, S>(
        context,
        pageKey: closer.key,
        dialogVisibilityGetter: dialogVisibilityGetter,
        removeAlsoThisPage: removeAlsoThisPage,
      );
    },
  );
  return await MyNavigator.showDialog<()>(context: context, page: page);
}

Widget _loadingDialogContent<B extends StateStreamable<S>, S>(
  BuildContext context, {
  required PageKey pageKey,
  required bool Function(S) dialogVisibilityGetter,
  required PageKey removeAlsoThisPage,
}) {
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
                MyNavigator.removeMultiplePages(context, [removeAlsoThisPage, pageKey]);
              }
              return commonLoadingDialogIndicator();
            },
          ),
        ],
      ),
    ),
  );
}
