
import 'package:app/api/api_manager.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/boolean_value_editor.dart';
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

class AdminNotificationScreen extends EditBooleanValuesScreen {
  const AdminNotificationScreen({
    required super.pageKey,
    super.key,
  }) : super(
    dataApi: const AdminNotificationsDataApi(),
    title: ADMIN_NOTIFICATIONS_TITLE,
  );
}

class AdminNotificationsDataApi extends EditBooleanValuesDataApi {
  const AdminNotificationsDataApi();

  @override
  Future<Result<BooleanValuesManager, ()>> load(ApiManager api) async {
    return await api
      .commonAdmin(
        (api) => api.getAdminNotificationSubscriptions()
      ).mapOk((v) => BooleanValuesManager(v.toJson()))
      .emptyErr();
  }

  @override
  Future<Result<(), ()>> save(ApiManager api, BooleanValuesManager values) async {
    final subscriptions = AdminNotification.fromJson(values.editedState());
    if (subscriptions == null) {
      return const Err(());
    }

    return await api
      .commonAdminAction(
        (api) => api.postAdminNotificationSubscriptions(subscriptions)
      ).emptyErr();
  }
}
