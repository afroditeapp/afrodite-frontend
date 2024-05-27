

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account_details.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account_details.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/my_profile.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/padding.dart';

class AccountSettingsScreen extends StatefulWidget {
  final AccountDetailsBloc accountDetailsBloc;
  const AccountSettingsScreen({
    required this.accountDetailsBloc,
    Key? key,
  }) : super(key: key);

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
      appBar: AppBar(
        title: Text(context.strings.account_settings_screen_title),
      ),
      body: content(),
    );
  }

  Widget content() {
    return BlocBuilder<AccountDetailsBloc, AccountDetailsBlocData>(
      builder: (context, state) {

        final birthdate = state.birthdate;
        final email = state.email;
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.isError || birthdate == null || email == null) {
          return Center(child: Text(context.strings.generic_error));
        } else {
          return successfulLoading(context, email, birthdate);
        }
      }
    );
  }

  Widget successfulLoading(
    BuildContext context,
    String email,
    String birthdate,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(4)),
        hPad(Text(
          context.strings.account_settings_screen_email_title,
          style: Theme.of(context).textTheme.titleSmall,
        )),
        hPad(Text(email)),
        const Padding(padding: EdgeInsets.all(4)),
        hPad(Text(
          context.strings.account_settings_screen_birthdate_title,
          style: Theme.of(context).textTheme.titleSmall,
        )),
        hPad(Text(birthdate)),
        const Padding(padding: EdgeInsets.all(4)),
        deleteAccount(),
      ],
    );
  }

  Widget deleteAccount() {
    return Setting.createSetting(Icons.delete, context.strings.account_settings_screen_delete_account_action, () async {
      final accepted = await showConfirmDialog(context, context.strings.account_settings_screen_delete_account_confirm_dialog_title);
      if (accepted == true) {
        widget.accountDetailsBloc.add(MoveAccountToPendingDeletionState());
      }
    }).toListTile();
  }
}
