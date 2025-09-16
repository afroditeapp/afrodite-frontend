import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account_details.dart';
import 'package:app/model/freezed/logic/account/account_details.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';

void openAccountSettings(BuildContext context) {
  MyNavigator.push(context, AccountSettingsPage());
}

class AccountSettingsPage extends MyScreenPage<()> {
  AccountSettingsPage() : super(builder: (_) => AccountSettingsScreenOpener());
}

class AccountSettingsScreenOpener extends StatelessWidget {
  const AccountSettingsScreenOpener({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountSettingsScreen(accountDetailsBloc: context.read<AccountDetailsBloc>());
  }
}

class AccountSettingsScreen extends StatefulWidget {
  final AccountDetailsBloc accountDetailsBloc;
  const AccountSettingsScreen({required this.accountDetailsBloc, super.key});

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
    return BlocBuilder<AccountDetailsBloc, AccountDetailsBlocData>(
      builder: (context, state) {
        final email = state.email;
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.isError || email == null) {
          return Center(child: Text(context.strings.generic_error));
        } else {
          return successfulLoading(context, email);
        }
      },
    );
  }

  Widget successfulLoading(BuildContext context, String email) {
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
