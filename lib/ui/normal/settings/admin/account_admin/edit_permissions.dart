

import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';

class EditPermissionsScreen extends StatefulWidget {
  final PageKey pageKey;
  final AccountId account;
  const EditPermissionsScreen({
    required this.pageKey,
    required this.account,
    super.key,
  });

  @override
  State<EditPermissionsScreen> createState() => _EditPermissionsScreenState();
}

class _EditPermissionsScreenState extends State<EditPermissionsScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final profile = LoginRepository.getInstance().repositories.profile;

  List<String> permissionsJsonKeys = [];
  Map<String, dynamic> permissionsJsonNoEdits = {};
  Map<String, dynamic> permissionsJson = {};
  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await api
      .accountAdmin(
        (api) => api.getAccountStateAdmin(widget.account.aid)
      ).ok();

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
        permissionsJson = result.permissions.toJson();
        permissionsJsonNoEdits = result.permissions.toJson();
        permissionsJsonKeys = permissionsJson.entries.map((v) => v.key).toList();
        permissionsJsonKeys.sortBy((v) => v);
      });
    }
  }

  Future<void> savePermissions() async {
    final permissions = Permissions.fromJson(permissionsJson);
    if (permissions == null) {
      showSnackBar(R.strings.generic_error);
      return;
    }

    final result = await api
      .accountAdminAction(
        (api) => api.postSetPermissions(widget.account.aid, permissions)
      );

    if (result.isErr()) {
      showSnackBar(R.strings.generic_error);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  bool unsavedChanges() {
    for (final k in permissionsJsonKeys) {
      if (permissionsJsonNoEdits[k] != permissionsJson[k]) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    Widget saveButton;
    if (unsavedChanges()) {
      saveButton = FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          final r = await showConfirmDialog(
            context,
            context.strings.generic_save_confirmation_title,
            details: changesText(),
            scrollable: true,
          );
          if (r == true && context.mounted) {
            await savePermissions();
            if (context.mounted) {
              MyNavigator.removePage(context, widget.pageKey);
            }
          }
        },
      );
    } else {
      saveButton = const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit permissions"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                for (final k in permissionsJsonKeys) {
                  permissionsJson[k] = false;
                }
              });
            },
            icon: const Icon(Icons.deselect),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                for (final k in permissionsJsonKeys) {
                  permissionsJson[k] = true;
                }
              });
            },
            icon: const Icon(Icons.select_all),
          )
        ],
      ),
      body: screenContent(context),
      floatingActionButton: saveButton,
    );
  }

  Widget screenContent(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (isError) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return showData(context);
    }
  }

  Widget showData(BuildContext context) {
    return ListView.builder(
      itemCount: permissionsJsonKeys.length + 1,
      itemBuilder: (context, i) {
        if (i == permissionsJsonKeys.length) {
          return const Padding(padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA));
        }

        final name = permissionsJsonKeys[i];
        final value = permissionsJson[name];

        return CheckboxListTile(
          value: value == true,
          onChanged: (newValue) {
            if (value != null) {
              setState(() {
                permissionsJson[name] = newValue;
              });
            }
          },
          title: Text(name),
        );
      },
    );
  }

  String changesText() {
    String added = "";
    for (final k in permissionsJsonKeys) {
      if (permissionsJson[k] != permissionsJsonNoEdits[k] && permissionsJson[k] == true) {
        added = "$added\n$k";
      }
    }
    added = added.trim();

    String removed = "";
    for (final k in permissionsJsonKeys) {
      if (permissionsJson[k] != permissionsJsonNoEdits[k] && permissionsJson[k] == false) {
        removed = "$removed\n$k";
      }
    }
    removed = removed.trim();

    String info = "";

    if (added.isNotEmpty) {
      info = "Added:\n\n$added";
    }

    if (removed.isNotEmpty) {
      info = "$info\n\nRemoved:\n\n$removed";
    }

    return info.trim();
  }
}
