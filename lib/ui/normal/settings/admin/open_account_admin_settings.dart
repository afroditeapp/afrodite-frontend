

import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

class OpenAccountAdminSettings extends StatefulWidget {
  const OpenAccountAdminSettings({super.key});

  @override
  State<OpenAccountAdminSettings> createState() => _OpenAccountAdminSettingsState();
}

class _OpenAccountAdminSettingsState extends State<OpenAccountAdminSettings> {
  final TextEditingController _emailController = TextEditingController();
  final api = LoginRepository.getInstance().repositories.api;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open account admin settings"),
      ),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final emailField = TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Account email address',
      ),
      controller: _emailController,
    );

    final openProfileButton = ElevatedButton(
      onPressed: () async {
        FocusScope.of(context).unfocus();

        final result = await api
          .accountAdmin(
            (api) => api.getAccountIdFromEmail(_emailController.text)
          ).ok();

        if (!context.mounted) {
          return;
        }

        final aid = result?.aid;
        if (result == null) {
          showSnackBar("Get account ID failed");
        } else if (aid == null) {
          showSnackBar("Email not found");
        } else {
          final ageAndName = await api
            .profileAdmin(
              (api) => api.getProfileAgeAndName(aid.aid)
            ).ok();

            if (!context.mounted) {
              return;
            }
          if (ageAndName == null) {
            showSnackBar("Get profile age and name failed");
          } else {
            await MyNavigator.push(context, MaterialPage<void>(child: AccountAdminSettingsScreen(
              accountId: aid,
              age: ageAndName.age,
              name: ageAndName.name,
            )));
          }
        }
      },
      child: const Text("Open"),
    );

    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(emailField),
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(openProfileButton),
      ],
    );
  }
}
