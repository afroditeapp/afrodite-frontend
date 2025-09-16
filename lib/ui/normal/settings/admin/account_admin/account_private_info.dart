import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/view_admins.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class AccountPrivateInfoPage extends MyScreenPageLimited<()> {
  AccountPrivateInfoPage(RepositoryInstances r, AccountId accountId)
    : super(builder: (_) => AccountPrivateInfoScreen(r, accountId));
}

class AccountPrivateInfoScreen extends StatefulWidget {
  final ApiManager api;
  final AccountId accountId;
  AccountPrivateInfoScreen(RepositoryInstances r, this.accountId, {super.key}) : api = r.api;

  @override
  State<AccountPrivateInfoScreen> createState() => _AccountPrivateInfoScreenState();
}

class _AccountPrivateInfoScreenState extends State<AccountPrivateInfoScreen> {
  Account? accountInfo;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await widget.api
        .accountAdmin((api) => api.getAccountStateAdmin(widget.accountId.aid))
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
        accountInfo = result;
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
      appBar: AppBar(title: const Text("Account private info")),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final account = accountInfo;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || account == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return showData(context, account, state.permissions);
        },
      );
    }
  }

  Widget showData(BuildContext context, Account account, Permissions myPermissions) {
    final permissions = enabledPermissions(account.permissions);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (permissions.isNotEmpty) const Padding(padding: EdgeInsets.all(8.0)),
          if (permissions.isNotEmpty) ...viewPermissions(context, permissions),
          const Padding(padding: EdgeInsets.all(8.0)),
          hPad(Text("State", style: Theme.of(context).textTheme.titleSmall)),
          hPad(Text(account.state.toAccountState().toString())),
          const Padding(padding: EdgeInsets.all(8.0)),
          hPad(Text("Profile visibility", style: Theme.of(context).textTheme.titleSmall)),
          hPad(Text(account.visibility.toString())),
          const Padding(padding: EdgeInsets.all(8.0)),
        ],
      ),
    );
  }

  List<Widget> viewPermissions(BuildContext context, String permissions) {
    return [
      hPad(Text("Permissions", style: Theme.of(context).textTheme.titleSmall)),
      hPad(Text(permissions)),
    ];
  }
}
