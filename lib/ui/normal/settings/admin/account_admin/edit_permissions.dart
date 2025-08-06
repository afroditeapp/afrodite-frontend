
import 'package:app/api/api_manager.dart';
import 'package:app/ui_utils/data_editor.dart';
import 'package:app/ui_utils/data_editor/base.dart';
import 'package:app/ui_utils/data_editor/boolean.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditPermissionsScreen extends EditDataScreen<PermissionsDataManager> {
  EditPermissionsScreen({
    required super.pageKey,
    required AccountId account,
    super.key,
  }) : super(
    dataApi: PermissionsDataApi(account),
    title: "Edit permissions",
  );
}

class PermissionsDataApi extends EditDataApi<PermissionsDataManager> {
  final AccountId account;
  const PermissionsDataApi(this.account);

  @override
  Future<Result<PermissionsDataManager, ()>> load(ApiManager api) async {
    return await api
      .accountAdmin(
        (api) => api.getPermissions(account.aid),
      ).mapOk((v) {
        final valueManager = BooleanValuesManager(v.toJson());
        return PermissionsDataManager(valueManager);
      }).emptyErr();
  }

  @override
  Future<Result<(), String>> save(ApiManager api, PermissionsDataManager values) async {
    final permissions = Permissions.fromJson(values.values.editedState());
    if (permissions == null) {
      return const Err("permissions == null");
    }

    return await api
      .accountAdminAction(
        (api) => api.postSetPermissions(account.aid, permissions)
      ).mapErr((_) => "API request failed");
  }
}

class PermissionsDataManager extends BaseDataManager implements DataManager, BooleanDataManager  {
  final BooleanValuesManager values;
  PermissionsDataManager(this.values);

  @override
  List<Widget> actions() => [
    BooleanDataDeselectAction(dataManager: this),
    BooleanDataSelectAction(dataManager: this),
  ];

  @override
  String changesText() => values.changesText();

  @override
  List<Widget> slivers() => [BooleanDataViewerSliver(dataManager: this)];

  @override
  bool unsavedChanges() => values.unsavedChanges();

  @override
  List<String> keys() => values.keys();

  @override
  String name(int i) => values.name(i);

  @override
  void setAll(bool value) => values.setAll(value);

  @override
  void setValue(int i, bool value) => values.setValue(i, value);

  @override
  bool value(int i) => values.value(i);
}
