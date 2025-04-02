

import 'package:app/localizations.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:openapi/api.dart';

class EditProfileNameScreen extends StatefulWidget {
  final AccountId accountId;
  final String initialName;
  const EditProfileNameScreen({
    required this.accountId,
    required this.initialName,
    super.key,
  });

  @override
  State<EditProfileNameScreen> createState() => _EditProfileNameScreenState();
}

class _EditProfileNameScreenState extends State<EditProfileNameScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final profile = LoginRepository.getInstance().repositories.profile;
  final chat = LoginRepository.getInstance().repositories.chat;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile name"),
      ),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final field = TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Profile name',
      ),
      controller: _controller,
    );

    final editButton = ElevatedButton(
      onPressed: () async {
        FocusScope.of(context).unfocus();

        final result = await showConfirmDialog(context, "Update?", yesNoActions: true);
        if (result == true && context.mounted) {
          final result = await api
            .profileAdminAction(
              (api) => api.postSetProfileName(
                SetProfileName(
                  account: widget.accountId,
                  name: _controller.text,
                )
              ));
          if (result.isErr()) {
            showSnackBar(R.strings.generic_error);
          } else {
            showSnackBar(R.strings.generic_action_completed);
          }

          await profile.downloadProfileToDatabase(chat, widget.accountId);
        }
      },
      child: const Text("Edit"),
    );

    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(field),
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(editButton),
      ],
    );
  }
}
