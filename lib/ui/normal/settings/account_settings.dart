import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/account/account_details.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account_details.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/time.dart';
import 'package:utils/utils.dart';

void openAccountSettings(BuildContext context) {
  MyNavigator.push(context, AccountSettingsPage());
}

class AccountSettingsPage extends MyScreenPage<()> with SimpleUrlParser<AccountSettingsPage> {
  AccountSettingsPage() : super(builder: (_) => AccountSettingsScreenOpener());

  @override
  AccountSettingsPage create() => AccountSettingsPage();
}

class AccountSettingsScreenOpener extends StatelessWidget {
  const AccountSettingsScreenOpener({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountSettingsScreen(
      accountDetailsBloc: context.read<AccountDetailsBloc>(),
      accountBloc: context.read<AccountBloc>(),
    );
  }
}

class AccountSettingsScreen extends StatefulWidget {
  final AccountDetailsBloc accountDetailsBloc;
  final AccountBloc accountBloc;
  const AccountSettingsScreen({
    required this.accountDetailsBloc,
    required this.accountBloc,
    super.key,
  });

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  void initState() {
    super.initState();
    widget.accountDetailsBloc.add(Reload());
  }

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<AccountDetailsBloc, AccountDetailsBlocData>(
      context: context,
      pageKey: null,
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.account_settings_screen_title)),
        body: content(),
      ),
    );
  }

  Widget content() {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      bloc: widget.accountBloc,
      builder: (context, accountState) {
        return BlocBuilder<AccountDetailsBloc, AccountDetailsBlocData>(
          builder: (context, state) {
            final email = state.email;
            final emailVerified = accountState.emailVerified;
            final emailChange = state.emailChange;
            final emailChangeVerified = state.emailChangeVerified;
            final emailChangeCompletionTime = state.emailChangeCompletionTime;
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.isError || email == null) {
              return Center(child: Text(context.strings.generic_error));
            } else {
              return successfulLoading(
                context,
                email,
                emailVerified,
                emailChange,
                emailChangeVerified,
                emailChangeCompletionTime,
              );
            }
          },
        );
      },
    );
  }

  Widget successfulLoading(
    BuildContext context,
    String email,
    bool emailVerified,
    String? emailChange,
    bool? emailChangeVerified,
    UtcDateTime? emailChangeCompletionTime,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(4)),
        hPad(
          Text(
            context.strings.account_settings_screen_email_title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        hPad(Text(email)),
        const Padding(padding: EdgeInsets.all(4)),
        hPad(
          Row(
            children: [
              Icon(
                emailVerified ? Icons.check : Icons.warning,
                color: emailVerified ? Colors.green : Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                emailVerified
                    ? context.strings.account_settings_screen_email_verified
                    : context.strings.account_settings_screen_email_not_verified,
              ),
            ],
          ),
        ),
        if (!emailVerified) ...[
          const Padding(padding: EdgeInsets.all(8)),
          hPad(
            ElevatedButton(
              onPressed: () {
                widget.accountDetailsBloc.add(SendVerificationEmail());
              },
              child: Text(context.strings.account_settings_screen_send_verification_email_button),
            ),
          ),
        ],
        const Padding(padding: EdgeInsets.all(8)),
        if (emailChange == null)
          hPad(
            ElevatedButton(
              onPressed: () async {
                final newEmail = await showChangeEmailDialog(context);
                if (newEmail != null) {
                  widget.accountDetailsBloc.add(RequestInitEmailChange(newEmail));
                }
              },
              child: Text(context.strings.account_settings_screen_change_email_button),
            ),
          ),
        if (emailChange != null) ...[
          hPad(
            Text(
              context.strings.account_settings_screen_pending_email_title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          hPad(Text(emailChange)),
          const Padding(padding: EdgeInsets.all(4)),
          hPad(
            Row(
              children: [
                Icon(
                  emailChangeVerified == true ? Icons.check : Icons.warning,
                  color: emailChangeVerified == true ? Colors.green : Colors.orange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  emailChangeVerified == true
                      ? context.strings.account_settings_screen_pending_email_verified
                      : context.strings.account_settings_screen_pending_email_not_verified,
                ),
              ],
            ),
          ),
          if (emailChangeCompletionTime != null) ...[
            const Padding(padding: EdgeInsets.all(4)),
            hPad(
              Text(
                context.strings.account_settings_screen_pending_email_completion_time(
                  fullTimeString(emailChangeCompletionTime),
                ),
              ),
            ),
          ],
          const Padding(padding: EdgeInsets.all(8)),
          hPad(
            ElevatedButton(
              onPressed: () async {
                final confirmed = await showConfirmDialog(
                  context,
                  context.strings.account_settings_screen_cancel_email_change_confirm_dialog_title,
                );
                if (confirmed == true) {
                  widget.accountDetailsBloc.add(RequestCancelEmailChange());
                }
              },
              child: Text(context.strings.account_settings_screen_cancel_email_change_button),
            ),
          ),
        ],
        const Padding(padding: EdgeInsets.all(4)),
        deleteAccount(),
      ],
    );
  }

  Widget deleteAccount() {
    return Setting.createSetting(
      Icons.delete,
      context.strings.account_settings_screen_delete_account_action,
      () async {
        final accepted = await showConfirmDialog(
          context,
          context.strings.account_settings_screen_delete_account_confirm_dialog_title,
        );
        if (accepted == true) {
          widget.accountDetailsBloc.add(MoveAccountToPendingDeletionState());
        }
      },
    ).toListTile();
  }
}

class ChangeEmailDialogPage extends MyDialogPage<String> {
  ChangeEmailDialogPage({required super.builder});
}

Future<String?> showChangeEmailDialog(BuildContext context) async {
  final result = await MyNavigator.showDialog<String>(
    context: context,
    page: ChangeEmailDialogPage(
      builder: (context, closer) {
        return _ChangeEmailDialog(closer: closer);
      },
    ),
  );
  return (result == null || result.isEmpty) ? null : result;
}

class _ChangeEmailDialog extends StatefulWidget {
  final PageCloser<String> closer;

  const _ChangeEmailDialog({required this.closer});

  @override
  State<_ChangeEmailDialog> createState() => _ChangeEmailDialogState();
}

class _ChangeEmailDialogState extends State<_ChangeEmailDialog> {
  String currentText = "";
  bool get isValidEmail => currentText.contains('@');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.strings.account_settings_screen_change_email_dialog_title),
      content: TextField(
        decoration: InputDecoration(
          hintText: context.strings.account_settings_screen_change_email_dialog_hint,
        ),
        keyboardType: TextInputType.emailAddress,
        autofocus: true,
        onChanged: (text) {
          setState(() {
            currentText = text;
          });
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => widget.closer.close(context, ""),
          child: Text(context.strings.generic_cancel),
        ),
        TextButton(
          onPressed: isValidEmail
              ? () {
                  widget.closer.close(context, currentText.trim());
                }
              : null,
          child: Text(context.strings.generic_ok),
        ),
      ],
    );
  }
}
