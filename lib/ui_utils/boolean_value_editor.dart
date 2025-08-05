
import 'package:app/api/api_manager.dart';
import 'package:collection/collection.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

abstract class EditBooleanValuesDataApi {
  const EditBooleanValuesDataApi();
  Future<Result<BooleanValuesManager, ()>> load(ApiManager api);
  Future<Result<(), ()>> save(ApiManager api, BooleanValuesManager values);
}

class EditBooleanValuesScreen extends StatefulWidget {
  final PageKey pageKey;
  final String title;
  final EditBooleanValuesDataApi dataApi;
  const EditBooleanValuesScreen({
    required this.pageKey,
    required this.title,
    required this.dataApi,
    super.key,
  });

  @override
  State<EditBooleanValuesScreen> createState() => _EditBooleanValuesScreenState();
}

class _EditBooleanValuesScreenState extends State<EditBooleanValuesScreen> {
  final api = LoginRepository.getInstance().repositories.api;

  BooleanValuesManager valuesManager = BooleanValuesManager.empty();
  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await widget.dataApi.load(api).ok();

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
        valuesManager = result;
      });
    }
  }

  Future<void> savePermissions() async {
    final result = await widget.dataApi.save(api, valuesManager);
    if (result.isErr()) {
      showSnackBar(R.strings.generic_error);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    Widget saveButton;
    if (valuesManager.unsavedChanges()) {
      saveButton = FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          final r = await showConfirmDialog(
            context,
            context.strings.generic_save_confirmation_title,
            details: valuesManager.changesText(),
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
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                valuesManager.setAll(false);
              });
            },
            icon: const Icon(Icons.deselect),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                valuesManager.setAll(true);
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
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: valuesManager.keys().length,
          itemBuilder: (context, i) {
            return CheckboxListTile(
              value: valuesManager.value(i),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    valuesManager.setValue(i, newValue);
                  });
                }
              },
              title: Text(valuesManager.name(i)),
            );
          },
        ),
        const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA))),
      ],
    );
  }
}

class BooleanValuesManager {
  List<String> _jsonKeys = [];
  Map<String, dynamic> _originalState = {};
  Map<String, dynamic> _editedState = {};
  BooleanValuesManager._(this._jsonKeys, this._originalState) : _editedState = { ..._originalState };

  BooleanValuesManager.empty();

  factory BooleanValuesManager(Map<String, dynamic> jsonObject) {
    final keys = jsonObject.entries.map((v) => v.key).toList();
    keys.sortBy((v) => v);
    return BooleanValuesManager._(
      keys,
      { ...jsonObject },
    );
  }

  List<String> keys() => _jsonKeys;

  Map<String, dynamic> editedState() => _editedState;

  String name(int index) => _jsonKeys[index];
  bool value(int index) => _editedState[name(index)] == true;

  void setValue(int index, bool value) {
    final name = _jsonKeys[index];
    _editedState[name] = value;
  }

  void setAll(bool value) {
    for (final k in _jsonKeys) {
      _editedState[k] = value;
    }
  }

  bool unsavedChanges() {
    for (final k in _jsonKeys) {
      if (_originalState[k] != _editedState[k]) {
        return true;
      }
    }
    return false;
  }

  String changesText() {
    String added = "";
    for (final k in _jsonKeys) {
      if (_editedState[k] != _originalState[k] && _editedState[k] == true) {
        added = "$added\n$k";
      }
    }
    added = added.trim();

    String removed = "";
    for (final k in _jsonKeys) {
      if (_editedState[k] != _originalState[k] && _editedState[k] == false) {
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
