import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/extensions/locale.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/time.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class LoginManagementPage extends MyScreenPageLimited<()> {
  LoginManagementPage(RepositoryInstances r, AccountId accountId)
    : super(builder: (_) => LoginManagementScreen(r, accountId));
}

class LoginManagementScreen extends StatefulWidget {
  final ApiManager api;
  final AccountId accountId;
  LoginManagementScreen(RepositoryInstances r, this.accountId, {super.key}) : api = r.api;

  @override
  State<LoginManagementScreen> createState() => _LoginManagementScreenState();
}

class _LoginManagementScreenState extends State<LoginManagementScreen> {
  AccountLockedState? lockedState;
  GetAccountLoginSessionInfo? loginSessionInfo;
  SignInWithState? signInWithState;
  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final lockedStateResult = await widget.api
        .accountAdmin((api) => api.getAccountLockedState(widget.accountId.aid))
        .ok();
    final sessionInfoResult = await widget.api
        .accountAdmin((api) => api.getAccountLoginSessionInfo(widget.accountId.aid))
        .ok();
    final signInWithStateResult = await widget.api
        .accountAdmin((api) => api.getAccountSignInWithStateAdmin(widget.accountId.aid))
        .ok();

    if (!context.mounted) {
      return;
    }

    if (lockedStateResult == null || sessionInfoResult == null || signInWithStateResult == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        lockedState = lockedStateResult;
        loginSessionInfo = sessionInfoResult;
        signInWithState = signInWithStateResult;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login management")),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || lockedState == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return showData(context, lockedState!, state.permissions);
        },
      );
    }
  }

  Widget showData(BuildContext context, AccountLockedState state, Permissions myPermissions) {
    final canEdit = myPermissions.adminEditLogin;
    final info = loginSessionInfo?.info;
    final localeString = Localizations.localeOf(context).localeString();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.locked) const Padding(padding: EdgeInsets.all(8.0)),
          if (state.locked) hPad(const Text("Account locked")),
          if (canEdit) const Padding(padding: EdgeInsets.all(8.0)),
          if (canEdit)
            hPad(
              ElevatedButton.icon(
                onPressed: () => _toggleLockState(state),
                icon: Icon(state.locked ? Icons.lock_open : Icons.lock),
                label: Text(state.locked ? "Unlock account" : "Lock account"),
              ),
            ),
          if (canEdit) const Padding(padding: EdgeInsets.all(8.0)),
          if (canEdit) const Divider(),
          if (canEdit) const Padding(padding: EdgeInsets.all(8.0)),
          if (canEdit)
            hPad(
              ElevatedButton.icon(
                onPressed: _logoutAccount,
                icon: const Icon(Icons.logout),
                label: const Text("Logout account"),
              ),
            ),
          const Padding(padding: EdgeInsets.all(8.0)),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0)),
          hPad(Text("Login session info", style: Theme.of(context).textTheme.titleSmall)),
          hPad(Text("Logged in: ${loginSessionInfo?.loggedIn ?? false}")),
          if (info == null)
            hPad(const Text("No login session info available"))
          else ...[
            hPad(Text("Client platform: ${info.clientPlatform?.toString() ?? "Unknown"}")),
            hPad(Text("Client IP: ${info.clientIp}")),
            hPad(Text("Client port: ${info.clientPort?.port.toString() ?? "Unknown"}")),
            hPad(Text("Login method: ${info.loginMethod}")),
            hPad(
              Text(
                "Session start: ${fullTimeString(info.startUnixTime.toUtcDateTime(), localeString)}",
              ),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            hPad(Text("App attestation", style: Theme.of(context).textTheme.titleSmall)),
            hPad(Text("App integrity: ${info.appAttestationAppIntegrity}")),
            hPad(Text("Device integrity: ${info.appAttestationDeviceIntegrity}")),
            hPad(Text("App attestation failed: ${info.appAttestationFailed}")),
            hPad(
              Text(
                "App attestation type: "
                "${info.appAttestationTypeNumber?.toString() ?? "Unknown"}",
              ),
            ),
          ],
          const Padding(padding: EdgeInsets.all(8.0)),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0)),
          hPad(
            Text("Sign in with Apple and Google", style: Theme.of(context).textTheme.titleSmall),
          ),
          if (signInWithState == null)
            hPad(const Text("No sign in with state available"))
          else ...[
            hPad(Text("Apple: ${signInWithState!.apple}")),
            hPad(Text("Google: ${signInWithState!.google}")),
          ],
          const Padding(padding: EdgeInsets.all(8.0)),
        ],
      ),
    );
  }

  Future<void> _toggleLockState(AccountLockedState currentState) async {
    final newLocked = !currentState.locked;
    final confirmText = newLocked ? "Lock?" : "Unlock?";

    final confirmed = await showConfirmDialog(context, confirmText);

    if (confirmed != true) {
      return;
    }

    final newState = AccountLockedState(locked: newLocked);
    final result = await widget.api
        .accountAdminAction((api) => api.postSetAccountLockedState(widget.accountId.aid, newState))
        .ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
    } else {
      showSnackBar(newLocked ? "Account locked" : "Account unlocked");
      setState(() {
        lockedState = newState;
      });
    }
  }

  Future<void> _logoutAccount() async {
    final confirmed = await showConfirmDialog(context, "Logout?");

    if (confirmed != true) {
      return;
    }

    final result = await widget.api
        .accountAdminAction((api) => api.postAdminLogout(widget.accountId.aid))
        .ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
    } else {
      showSnackBar("Account logged out successfully");
    }
  }
}
