
import 'package:app/api/api_manager.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/data_editor.dart';
import 'package:app/ui_utils/data_editor/base.dart';
import 'package:app/ui_utils/data_editor/boolean.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

const ADMIN_NOTIFICATIONS_TITLE = "Admin notifications";

Future<void> openAdminNotificationsScreen(
  BuildContext context,
) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(
      child: AdminNotificationScreen(pageKey: pageKey),
    ),
    pageKey,
  );
}

class AdminNotificationScreen extends EditDataScreen<AdminNotificationDataManager> {
  const AdminNotificationScreen({
    required super.pageKey,
    super.key,
  }) : super(
    dataApi: const AdminNotificationDataApi(),
    title: ADMIN_NOTIFICATIONS_TITLE,
  );
}

class AdminNotificationDataApi extends EditDataApi<AdminNotificationDataManager> {
  const AdminNotificationDataApi();

  @override
  Future<Result<AdminNotificationDataManager, ()>> load(ApiManager api) async {
    return await api
      .commonAdmin(
        (api) => api.getAdminNotificationSubscriptions(),
      ).mapOk((v) {
        final valueManager = BooleanValuesManager(v.toJson());
        return AdminNotificationDataManager(valueManager);
      }).emptyErr();
  }

  @override
  Future<Result<(), ()>> save(ApiManager api, AdminNotificationDataManager values) async {
    final subscriptions = AdminNotification.fromJson(values.values.editedState());
    if (subscriptions == null) {
      return const Err(());
    }

    return await api
      .commonAdminAction(
        (api) => api.postAdminNotificationSubscriptions(subscriptions)
      ).emptyErr();
  }
}

class AdminNotificationDataManager extends BaseDataManager implements DataManager, BooleanDataManager  {
  final BooleanValuesManager values;
  AdminNotificationDataManager(this.values);

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
