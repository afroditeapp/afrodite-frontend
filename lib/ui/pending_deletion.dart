import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/ui/normal/settings/data_export.dart";
import "package:app/ui_utils/app_bar/common_actions.dart";
import "package:app/ui_utils/app_bar/menu_actions.dart";
import "package:app/ui_utils/dialog.dart";
import "package:app/ui_utils/list.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/api.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";
import "package:flutter/material.dart";
import "package:openapi/api.dart";

class PendingDeletionPage extends StatefulWidget {
  const PendingDeletionPage({super.key});

  @override
  State<PendingDeletionPage> createState() => _PendingDeletionPageState();
}

class _PendingDeletionPageState extends State<PendingDeletionPage> {
  final api = LoginRepository.getInstance().repositories.api;
  final connectionManager = LoginRepository.getInstance().repositories.connectionManager;
  final currentUser = LoginRepository.getInstance().repositories.accountId;

  bool isLoading = true;
  UnixTime? data;

  Future<void> _refreshData() async {
    await connectionManager.tryWaitUntilConnected(waitTimeoutSeconds: 5);

    final result = await api
      .account(
        (api) => api.getAccountDeletionRequestState(currentUser.aid),
      ).ok();

    if (context.mounted) {
      setState(() {
        isLoading = false;
        data = result?.automaticDeletionAllowed;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.strings.account_deletion_pending_screen_title),
          actions: [
            menuActions([
              MenuItemButton(
                child: Text(context.strings.data_export_screen_title_export_type_user),
                onPressed: () {
                  openDataExportScreen(
                    context,
                    context.strings.data_export_screen_title_export_type_user,
                    currentUser,
                    DataExportType.user,
                  );
                }
              ),
              ...commonActionsWhenLoggedInAndAccountIsNotNormallyUsable(context),
            ]),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: constraints,
                  child: screenContent(context),
                ),
              ),
            );
          }
        ),
      );
  }

  Widget screenContent(BuildContext context) {
    if (isLoading) {
      return buildProgressIndicator();
    } else {
      return showData(context, data);
    }
  }

  Widget buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showData(BuildContext context, UnixTime? deletionAllowedTime) {
    List<Widget> widgets;
    if (deletionAllowedTime == null) {
      widgets = [
        Text(context.strings.generic_error_occurred),
      ];
    } else {
      final localTime = fullTimeString(deletionAllowedTime.toUtcDateTime());
      widgets = [
        Text(context.strings.account_deletion_pending_screen_time_text(localTime)),
        const Padding(padding: EdgeInsets.only(top: 8)),
        ElevatedButton(
          child: Text(context.strings.generic_cancel),
          onPressed: () async {
            final result = await showConfirmDialog(context, context.strings.generic_cancel_question, yesNoActions: true);
            if (result == true) {
              final result = await api
                .accountAction(
                  (api) => api.postSetAccountDeletionRequestState(currentUser.aid, BooleanSetting(value: false)),
                );
              if (result.isErr()) {
                showSnackBar(R.strings.generic_error_occurred);
              }
            }
          },
        ),
      ];
    }
    return buildListReplacementMessage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      )
    );
  }
}
