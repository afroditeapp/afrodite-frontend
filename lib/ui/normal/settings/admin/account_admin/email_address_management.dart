import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:openapi/api.dart';

class EmailAddressManagementPage extends MyScreenPageLimited<()> {
  EmailAddressManagementPage(RepositoryInstances r, AccountId accountId)
    : super(builder: (_) => EmailAddressManagementScreen(r, accountId));
}

class EmailAddressManagementScreen extends StatefulWidget {
  final ApiManager api;
  final AccountId accountId;
  EmailAddressManagementScreen(RepositoryInstances r, this.accountId, {super.key}) : api = r.api;

  @override
  State<EmailAddressManagementScreen> createState() => _EmailAddressManagementScreenState();
}

class _EmailAddressManagementScreenState extends State<EmailAddressManagementScreen> {
  EmailAddressStateAdmin? emailState;
  bool isLoading = true;
  bool isError = false;

  final TextEditingController _newEmailController = TextEditingController();

  Future<void> _getData() async {
    final result = await widget.api
        .accountAdmin((api) => api.getEmailAddressStateAdmin(widget.accountId.aid))
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
        emailState = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Email address management")),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || emailState == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return showData(context, emailState!);
    }
  }

  Widget showData(BuildContext context, EmailAddressStateAdmin state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email address section
            Text("Email address", style: Theme.of(context).textTheme.titleMedium),
            const Padding(padding: EdgeInsets.all(8.0)),
            _buildEmailInfo(context, state),
            const Padding(padding: EdgeInsets.all(8.0)),

            // Email login section
            Text("Email login", style: Theme.of(context).textTheme.titleMedium),
            if (!state.emailLoginEnabled) const Padding(padding: EdgeInsets.all(8.0)),
            if (!state.emailLoginEnabled) Text("Email login is disabled"),
            const Padding(padding: EdgeInsets.all(8.0)),
            ElevatedButton.icon(
              onPressed: () => _toggleEmailLogin(state),
              icon: Icon(state.emailLoginEnabled ? Icons.email_outlined : Icons.email),
              label: Text(state.emailLoginEnabled ? "Disable email login" : "Enable email login"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInfo(BuildContext context, EmailAddressStateAdmin state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.email != null) ...[
          SelectableText(state.email!, style: Theme.of(context).textTheme.bodyLarge),
          const Padding(padding: EdgeInsets.all(8.0)),
        ] else ...[
          Text("No email address set", style: Theme.of(context).textTheme.bodyMedium),
          const Padding(padding: EdgeInsets.all(8.0)),
        ],

        if (state.emailChange != null) ...[
          Text("Email change in progress:"),
          const Padding(padding: EdgeInsets.all(4.0)),
          SelectableText(state.emailChange!),
          const Padding(padding: EdgeInsets.all(4.0)),
          Text(state.emailChangeVerified ? "Verified" : "Not verified"),
          const Padding(padding: EdgeInsets.all(8.0)),
          ElevatedButton.icon(
            onPressed: _cancelEmailChange,
            icon: const Icon(Icons.cancel),
            label: const Text("Cancel email change"),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
        ] else ...[
          const Padding(padding: EdgeInsets.all(8.0)),
          TextField(
            controller: _newEmailController,
            decoration: const InputDecoration(
              labelText: "New email address",
              hintText: "Enter new email address",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          ElevatedButton.icon(
            onPressed: _initiateEmailChange,
            icon: const Icon(Icons.edit),
            label: const Text("Initiate email change"),
          ),
        ],
      ],
    );
  }

  Future<void> _toggleEmailLogin(EmailAddressStateAdmin currentState) async {
    final newEnabled = !currentState.emailLoginEnabled;
    final confirmText = newEnabled ? "Enable?" : "Disable?";

    final confirmed = await showConfirmDialog(context, confirmText);

    if (confirmed != true) {
      return;
    }

    final request = SetEmailLoginEnabled(aid: widget.accountId, enabled: newEnabled);

    final result = await widget.api
        .accountAction((api) => api.postSetEmailLoginEnabled(request))
        .ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
    } else {
      showSnackBar(newEnabled ? "Email login enabled" : "Email login disabled");
      await _getData();
    }
  }

  Future<void> _initiateEmailChange() async {
    final newEmail = _newEmailController.text.trim();

    if (newEmail.isEmpty) {
      showSnackBar("Please enter an email address");
      return;
    }

    if (!newEmail.contains('@')) {
      showSnackBar("Please enter a valid email address");
      return;
    }

    final confirmed = await showConfirmDialog(context, "Initiate email change?", details: newEmail);

    if (confirmed != true) {
      return;
    }

    final request = InitEmailChangeAdmin(accountId: widget.accountId, newEmail: newEmail);

    final result = await widget.api
        .accountAdmin((api) => api.postAdminInitEmailChange(request))
        .ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
    } else if (result.errorEmailSendingFailed) {
      showSnackBar("Email sending failed");
    } else if (result.errorEmailSendingTimeout) {
      showSnackBar("Email sending timeout");
    } else if (result.errorTryAgainLaterAfterSeconds != null) {
      showSnackBar("Try again later after ${result.errorTryAgainLaterAfterSeconds} seconds");
    } else {
      showSnackBar("Email change initiated successfully");
      _newEmailController.clear();
    }

    if (result != null) {
      await _getData();
    }
  }

  Future<void> _cancelEmailChange() async {
    final confirmed = await showConfirmDialog(context, "Cancel?");

    if (confirmed != true) {
      return;
    }

    final result = await widget.api
        .accountAdminAction((api) => api.postAdminCancelEmailChange(widget.accountId.aid))
        .ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
    } else {
      showSnackBar("Email change cancelled");
      await _getData();
    }
  }
}
