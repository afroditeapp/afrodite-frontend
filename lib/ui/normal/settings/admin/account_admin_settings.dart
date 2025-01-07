
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class AccountAdminSettingsScreen extends StatefulWidget {
  final ProfileEntry entry;
  const AccountAdminSettingsScreen({
    required this.entry,
    super.key,
  });

  @override
  State<AccountAdminSettingsScreen> createState() => _AccountAdminSettingsScreenState();
}

class _AccountAdminSettingsScreenState extends State<AccountAdminSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account admin settings"),
      ),
      body: BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return screenContent(context, state.permissions);
        }
      ),
    );
  }

  Widget screenContent(BuildContext context, Permissions permissions) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(Text(
          "${widget.entry.name}, ${widget.entry.age}",
          style: Theme.of(context).textTheme.titleMedium,
        )),
        const Padding(padding: EdgeInsets.all(4.0)),
        hPad(Text(
          "Account ID: ${widget.entry.uuid.aid}",
          style: Theme.of(context).textTheme.bodySmall,
        )),
        const Padding(padding: EdgeInsets.all(8.0)),
      ],
    );
  }
}
