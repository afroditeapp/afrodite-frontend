import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:app/ui_utils/snack_bar.dart';
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
  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await widget.api
        .accountAdmin((api) => api.getAccountLockedState(widget.accountId.aid))
        .ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        lockedState = result;
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
      return showData(context, lockedState!);
    }
  }

  Widget showData(BuildContext context, AccountLockedState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.locked) const Padding(padding: EdgeInsets.all(8.0)),
          if (state.locked) hPad(Text("Account locked")),
          const Padding(padding: EdgeInsets.all(8.0)),
          hPad(
            ElevatedButton.icon(
              onPressed: () => _toggleLockState(state),
              icon: Icon(state.locked ? Icons.lock_open : Icons.lock),
              label: Text(state.locked ? "Unlock account" : "Lock account"),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0)),
          hPad(
            ElevatedButton.icon(
              onPressed: _logoutAccount,
              icon: const Icon(Icons.logout),
              label: const Text("Logout account"),
            ),
          ),
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
