
import 'package:app/api/api_manager.dart';
import 'package:app/ui_utils/boolean_value_editor.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';

class EditPermissionsScreen extends EditBooleanValuesScreen {
  EditPermissionsScreen({
    required super.pageKey,
    required AccountId account,
    super.key,
  }) : super(
    dataApi: PermissionsDataApi(account),
    title: "Edit permissions",
  );
}

class PermissionsDataApi extends EditBooleanValuesDataApi {
  final AccountId account;
  const PermissionsDataApi(this.account);

  @override
  Future<Result<BooleanValuesManager, void>> load(ApiManager api) async {
    return await api
      .accountAdmin(
        (api) => api.getPermissions(account.aid),
      ).mapOk((v) => BooleanValuesManager(v.toJson()));
  }

  @override
  Future<Result<void, void>> save(ApiManager api, BooleanValuesManager values) async {
    final permissions = Permissions.fromJson(values.editedState());
    if (permissions == null) {
      return const Err(null);
    }

    return await api
      .accountAdminAction(
        (api) => api.postSetPermissions(account.aid, permissions)
      );
  }
}
