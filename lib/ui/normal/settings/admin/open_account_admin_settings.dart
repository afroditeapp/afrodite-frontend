import 'package:app/data/utils/repository_instances.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:provider/provider.dart';

class OpenAccountAdminSettings extends StatefulWidget {
  const OpenAccountAdminSettings({super.key});

  @override
  State<OpenAccountAdminSettings> createState() => _OpenAccountAdminSettingsState();
}

class _OpenAccountAdminSettingsState extends State<OpenAccountAdminSettings> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Open account admin settings")),
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

    final r = context.read<RepositoryInstances>();

    final openProfileButton = ElevatedButton(
      onPressed: () async {
        FocusScope.of(context).unfocus();

        final result = await r.api
            .accountAdmin((api) => api.getAccountIdFromEmail(_emailController.text))
            .ok();

        if (!context.mounted) {
          return;
        }

        final aid = result?.aid;
        if (result == null) {
          showSnackBar("Get account ID failed");
        } else if (aid == null) {
          showSnackBar("Email not found");
        } else {
          await getAgeAndNameAndShowAdminSettings(context, r.api, aid);
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
