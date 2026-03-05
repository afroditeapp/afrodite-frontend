import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/add_attribute.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/attribute_editor.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/utils.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';

class ProfileAttributesSchemaPage extends MyScreenPageLimited<()> {
  ProfileAttributesSchemaPage(RepositoryInstances r)
    : super(builder: (closer) => ProfileAttributesSchemaScreen(r, closer));
}

class ProfileAttributesSchemaScreen extends StatefulWidget {
  final ApiManager api;
  final PageCloser<()> closer;
  ProfileAttributesSchemaScreen(RepositoryInstances r, this.closer, {super.key}) : api = r.api;

  @override
  State<ProfileAttributesSchemaScreen> createState() => _ProfileAttributesSchemaScreenState();
}

class _ProfileAttributesSchemaScreenState extends State<ProfileAttributesSchemaScreen> {
  bool isLoading = true;
  bool isError = false;

  ProfileAttributesSchemaExport? _initialSchema;
  ProfileAttributesSchemaExport? _currentSchema;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await widget.api.profileAdmin((api) => api.getProfileAttributesSchema()).ok();

    setState(() {
      isLoading = false;
      isError = data == null;
      if (data != null) {
        _initialSchema = ProfileAttributesSchemaExport.fromJson(jsonDecode(jsonEncode(data)));
        _currentSchema = ProfileAttributesSchemaExport.fromJson(jsonDecode(jsonEncode(data)));
      }
    });
  }

  bool _hasUnsavedChanges() {
    if (_initialSchema == null || _currentSchema == null) return false;
    return jsonEncode(_initialSchema) != jsonEncode(_currentSchema);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasUnsavedChanges(),
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        showConfirmDialog(
          context,
          context.strings.generic_save_confirmation_title,
          yesNoActions: true,
        ).then((value) {
          if (value == true && context.mounted) {
            _saveConfigAndCloseScreen();
          } else if (value == false && context.mounted) {
            widget.closer.close(context, ());
          }
        });
      },
      child: _scaffold(context),
    );
  }

  Widget _scaffold(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        final permissions = state.permissions;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile attributes schema"),
            actions: [
              menuActions([
                MenuItemButton(
                  onPressed: _currentSchema == null
                      ? null
                      : () async {
                          await _addAttribute(context);
                        },
                  child: const Text("Add attribute"),
                ),
                MenuItemButton(
                  onPressed: _currentSchema == null ? null : _exportSchema,
                  child: const Text("Export"),
                ),
                MenuItemButton(onPressed: _importSchema, child: const Text("Import")),
              ]),
            ],
          ),
          body: displayState(context, permissions),
          floatingActionButton: _hasUnsavedChanges()
              ? FloatingActionButton(
                  onPressed: () {
                    showConfirmDialog(context, "Save schema?").then((value) async {
                      if (value == true && context.mounted) {
                        await _saveConfigAndCloseScreen();
                      }
                    });
                  },
                  child: const Icon(Icons.save),
                )
              : null,
        );
      },
    );
  }

  Future<void> _addAttribute(BuildContext context) async {
    final schema = _currentSchema;
    if (schema == null) {
      return;
    }
    final nextId = schema.attributes.isEmpty
        ? 1
        : schema.attributes.map((e) => e.id).reduce(max) + 1;
    final nextOrderNumber = nextAttributeOrderNumber(schema.attributes);
    final newAttribute = await MyNavigator.pushLimited(
      context,
      AddAttributePage(nextId, nextOrderNumber: nextOrderNumber),
    );
    if (newAttribute != null) {
      setState(() {
        schema.attributes = [...schema.attributes, newAttribute];
      });
    }
  }

  Future<void> _exportSchema() async {
    final schema = _currentSchema;
    if (schema == null) return;

    final jsonString = jsonEncode(schema);
    final bytes = Uint8List.fromList(utf8.encode(jsonString));

    final timestamp = DateFormat('yyyy-MM-dd_HH-mm').format(DateTime.now());
    final fileName = "profile_attributes_schema_$timestamp.json";

    try {
      await FlutterFileSaver().writeFileAsBytes(fileName: fileName, bytes: bytes);
      if (mounted) {
        showSnackBar("Schema exported!");
      }
    } catch (e) {
      if (mounted) {
        showSnackBar("Export failed!");
      }
    }
  }

  Future<void> _importSchema() async {
    const typeGroup = XTypeGroup(label: 'JSON', extensions: <String>['json']);
    final XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file != null && mounted) {
      final confirm = await showConfirmDialog(
        context,
        "Import schema?",
        details: "This will overwrite your unsaved changes with the contents of ${file.name}.",
        yesNoActions: true,
      );

      if (confirm == true && mounted) {
        try {
          final jsonString = await File(file.path).readAsString();
          final data = jsonDecode(jsonString);
          final newSchema = ProfileAttributesSchemaExport.fromJson(data);
          if (newSchema != null) {
            setState(() {
              _currentSchema = newSchema;
            });
            showSnackBar("Schema imported!");
          } else {
            showSnackBar("Import failed! Invalid schema format.");
          }
        } catch (e) {
          showSnackBar("Import failed! Invalid JSON or schema format.");
        }
      }
    }
  }

  Widget displayState(BuildContext context, Permissions permissions) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return showContent(context, permissions);
    }
  }

  Widget showContent(BuildContext context, Permissions permissions) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.info_outline),
              SizedBox(width: 12),
              Expanded(
                child: Text("Note: Removing attributes or attribute values is not supported."),
              ),
            ],
          ),
        ),
        if (_currentSchema != null)
          ..._currentSchema!.attributes.map((attr) {
            return ListTile(
              title: Text("${attr.name} (${attr.key})"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mode: ${attr.mode.value}"),
                  TranslationSummary(
                    translationKey: attr.key,
                    translations: attr.translations,
                    multilineValues: true,
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final updatedAttr = await MyNavigator.pushLimited(
                  context,
                  AttributeEditorPage(attr, permissions),
                );
                if (updatedAttr != null) {
                  setState(() {
                    final index = _currentSchema!.attributes.indexWhere(
                      (a) => a.id == attr.id && a.key == attr.key,
                    );
                    if (index != -1) {
                      _currentSchema!.attributes[index] = updatedAttr;
                    }
                  });
                }
              },
            );
          }),
      ],
    );
  }

  Future<bool> _saveConfigAndCloseScreen() async {
    if (_initialSchema == null || _currentSchema == null) return false;

    final update = UpdateProfileAttributesSchema(
      currentState: _initialSchema!,
      newState: _currentSchema!,
    );

    final result = await widget.api.profileAdminAction(
      (api) => api.putProfileAttributesSchema(update),
    );
    switch (result) {
      case Ok():
        showSnackBar("Schema saved!");
      case Err():
        showSnackBar("Schema save failed!");
        return false;
    }

    if (mounted) {
      widget.closer.close(context, ());
    }

    return true;
  }
}
