import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui/normal/settings/account_settings.dart";
import "package:app/ui/normal/settings/data_export.dart";
import "package:app/ui_utils/app_bar/common_actions.dart";
import "package:app/ui_utils/app_bar/menu_actions.dart";
import "package:app/ui_utils/list.dart";
import "package:app/utils/api.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";
import "package:flutter/material.dart";
import "package:app/localizations.dart";
import "package:openapi/api.dart";

class AccountBannedPage extends MyScreenPage<()> with SimpleUrlParser<AccountBannedPage> {
  final RepositoryInstances r;
  AccountBannedPage(this.r) : super(builder: (_) => AccountBannedScreen(r));

  @override
  AccountBannedPage create() => AccountBannedPage(r);
}

class AccountBannedScreen extends StatefulWidget {
  final ApiManager api;
  final ServerConnectionManager connectionManager;
  final AccountId currentUser;
  AccountBannedScreen(RepositoryInstances r, {super.key})
    : api = r.api,
      connectionManager = r.connectionManager,
      currentUser = r.accountId;

  @override
  State<AccountBannedScreen> createState() => _AccountBannedScreenState();
}

class _AccountBannedScreenState extends State<AccountBannedScreen> {
  bool isLoading = true;
  GetAccountBanTimeResult? data;

  Future<void> _refreshData() async {
    await widget.connectionManager.tryWaitUntilConnected(waitTimeoutSeconds: 5);

    final result = await widget.api
        .account((api) => api.getAccountBanTime(widget.currentUser.aid))
        .ok();

    if (context.mounted) {
      setState(() {
        isLoading = false;
        data = result;
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
        title: Text(context.strings.account_banned_screen_title),
        actions: [
          menuActions([
            // Allow access to account deletion request UI
            MenuItemButton(
              child: Text(context.strings.account_settings_screen_title),
              onPressed: () => openAccountSettings(context),
            ),
            MenuItemButton(
              child: Text(context.strings.data_export_screen_title_export_type_user),
              onPressed: () {
                openDataExportScreenMyData(context);
              },
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
              child: ConstrainedBox(constraints: constraints, child: screenContent(context)),
            ),
          );
        },
      ),
    );
  }

  Widget screenContent(BuildContext context) {
    if (isLoading) {
      return buildProgressIndicator();
    } else {
      return showData(context);
    }
  }

  Widget buildProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget showData(BuildContext context) {
    final GetAccountBanTimeResult? result = data;
    final UnixTime? bannedUntil = data?.bannedUntil;
    List<Widget> widgets;
    if (result == null) {
      widgets = [Text(context.strings.generic_error_occurred)];
    } else if (bannedUntil == null) {
      widgets = [Text(context.strings.generic_error)];
    } else {
      final String banReason = result.reasonDetails.value;
      final localTime = fullTimeString(bannedUntil.toUtcDateTime());
      widgets = [
        Text(context.strings.account_banned_screen_time_text(localTime)),
        const Padding(padding: EdgeInsets.only(top: 8)),
        if (banReason.isNotEmpty) Text(context.strings.account_banned_screen_ban_reason(banReason)),
      ];
    }
    return buildListReplacementMessage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }
}
