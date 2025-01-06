

import 'package:app/data/profile_repository.dart';
import 'package:app/ui/normal/profiles/view_profile.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

class OpenProfileScreen extends StatefulWidget {
  const OpenProfileScreen({super.key});

  @override
  State<OpenProfileScreen> createState() => _OpenProfileScreenState();
}

class _OpenProfileScreenState extends State<OpenProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final api = LoginRepository.getInstance().repositories.api;
  final profile = LoginRepository.getInstance().repositories.profile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open profile"),
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
          final entry = await profile.getProfile(aid);
            if (!context.mounted) {
              return;
            }
          if (entry == null) {
            showSnackBar("Get profile failed");
          } else {
            openProfileView(context, entry, null, ProfileRefreshPriority.low);
          }
        }
      },
      child: const Text("Open profile"),
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
