import 'package:app/ui_utils/data_editor/base.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

abstract class BooleanDataManager implements BaseDataManagerProvider {
  const BooleanDataManager();
  List<String> keys();
  bool value(int i);
  String name(int i);
  void setValue(int i, bool value);
  void setAll(bool value);
}

class BooleanDataViewerSliver extends StatefulWidget {
  final BooleanDataManager dataManager;
  const BooleanDataViewerSliver({required this.dataManager, super.key});

  @override
  State<BooleanDataViewerSliver> createState() => _BooleanDataViewerSliverState();
}

class _BooleanDataViewerSliverState extends State<BooleanDataViewerSliver>
    with RefreshSupport<BooleanDataViewerSliver> {
  @override
  BaseDataManager get baseDataManager => widget.dataManager.baseDataManager;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: widget.dataManager.keys().length,
      itemBuilder: (context, i) {
        return CheckboxListTile(
          value: widget.dataManager.value(i),
          onChanged: (newValue) {
            if (newValue != null) {
              widget.dataManager.setValue(i, newValue);
              widget.dataManager.baseDataManager.triggerUiRefresh();
            }
          },
          title: Text(widget.dataManager.name(i)),
        );
      },
    );
  }
}

class BooleanDataDeselectAction extends StatefulWidget {
  final BooleanDataManager dataManager;
  const BooleanDataDeselectAction({required this.dataManager, super.key});

  @override
  State<BooleanDataDeselectAction> createState() => _BooleanDataDeselectActionState();
}

class _BooleanDataDeselectActionState extends State<BooleanDataDeselectAction> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.dataManager.setAll(false);
        widget.dataManager.baseDataManager.triggerUiRefresh();
      },
      icon: const Icon(Icons.deselect),
    );
  }
}

class BooleanDataSelectAction extends StatefulWidget {
  final BooleanDataManager dataManager;
  const BooleanDataSelectAction({required this.dataManager, super.key});

  @override
  State<BooleanDataSelectAction> createState() => _BooleanDataSelectActionState();
}

class _BooleanDataSelectActionState extends State<BooleanDataSelectAction> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.dataManager.setAll(true);
        widget.dataManager.baseDataManager.triggerUiRefresh();
      },
      icon: const Icon(Icons.select_all),
    );
  }
}

class BooleanValuesManager {
  List<String> _jsonKeys = [];
  Map<String, dynamic> _originalState = {};
  Map<String, dynamic> _editedState = {};
  BooleanValuesManager._(this._jsonKeys, this._originalState) : _editedState = {..._originalState};

  BooleanValuesManager.empty();

  factory BooleanValuesManager(Map<String, dynamic> jsonObject) {
    final keys = jsonObject.entries.map((v) => v.key).toList();
    keys.sortBy((v) => v);
    return BooleanValuesManager._(keys, {...jsonObject});
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
