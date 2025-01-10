

import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class DeleteAccountScreen extends StatefulWidget {
  final AccountId accountId;
  const DeleteAccountScreen({
    required this.accountId,
    super.key,
  });

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final profile = LoginRepository.getInstance().repositories.profile;

  bool? pendingDeletion;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await api
      .accountAdmin(
        (api) => api.getAccountStateAdmin(widget.accountId.aid)
      ).ok();

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
        pendingDeletion = result.state.pendingDeletion;
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
      appBar: AppBar(
        title: const Text("Delete account"),
      ),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final pendingDeletionInfo = pendingDeletion;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (isError || pendingDeletionInfo == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return showData(context, pendingDeletionInfo, state.permissions);
        }
      );
    }
  }

  Widget showData(BuildContext context, bool pendingDeletionInfo, Permissions myPermissions) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (myPermissions.adminRequestAccountDeletion) const Padding(padding: EdgeInsets.all(8.0)),
          if (myPermissions.adminRequestAccountDeletion) deleteRequestWidgets(context, pendingDeletionInfo),
          if (myPermissions.adminDeleteAccount) const Padding(padding: EdgeInsets.all(8.0)),
          if (myPermissions.adminDeleteAccount) hPad(deleteWidget(context)),
          const Padding(padding: EdgeInsets.all(8.0)),
        ],
      ),
    );
  }

  Widget deleteRequestWidgets(BuildContext context, bool pendingDeletionInfo) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pendingDeletionInfo) hPad(const Text("Pending deletion")),
        if (!pendingDeletionInfo) hPad(const Text("Not pending deletion")),
        const Padding(padding: EdgeInsets.all(8.0)),
        if (pendingDeletionInfo) hPad(removeDeletionRequestWidget(context)),
        if (!pendingDeletionInfo) hPad(requestDeletionWidget(context)),
      ],
    );
  }

  Widget requestDeletionWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await showConfirmDialog(context, "Request deletion?", yesNoActions: true);
        if (result == true && context.mounted) {
          final result = await api
            .accountAction(
              (api) => api.postSetAccountDeletionRequestState(
                widget.accountId.aid,
                BooleanSetting(value: true),
              )
            );
          if (result.isErr()) {
            showSnackBar(R.strings.generic_error);
          }
          await _getData();
        }
      },
      child: const Text("Request deletion"),
    );
  }

  Widget removeDeletionRequestWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await showConfirmDialog(context, "Remove deletion request?", yesNoActions: true);
        if (result == true && context.mounted) {
          final result = await api
            .accountAction(
              (api) => api.postSetAccountDeletionRequestState(
                widget.accountId.aid,
                BooleanSetting(value: false),
              )
            );
          if (result.isErr()) {
            showSnackBar(R.strings.generic_error);
          }
          await _getData();
        }
      },
      child: const Text("Remove deletion request"),
    );
  }

  Widget deleteWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await showConfirmDialog(context, "Delete account?", yesNoActions: true);
        if (result == true && context.mounted) {
          final result = await api
            .accountAdminAction(
              (api) => api.postDeleteAccount(
                widget.accountId.aid,
              )
            );
          if (result.isErr()) {
            showSnackBar(R.strings.generic_error);
          } else {
            showSnackBar("Account deleted");
          }
        }
      },
      child: const Text("Delete account"),
    );
  }
}
