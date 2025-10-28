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
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.account_settings_screen_title)),
      body: content(),
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
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.isError || email == null) {
              return Center(child: Text(context.strings.generic_error));
            } else {
              return successfulLoading(context, email, emailVerified);
            }
          },
        );
      },
    );
  }

  Widget successfulLoading(BuildContext context, String email, bool emailVerified) {
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
