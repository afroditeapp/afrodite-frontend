import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/data_editor.dart';
import 'package:app/ui_utils/data_editor/base.dart';
import 'package:app/ui_utils/data_editor/boolean.dart';
import 'package:app/ui_utils/data_editor/day_timestamp.dart';
import 'package:app/ui_utils/data_editor/weekday.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

const ADMIN_NOTIFICATIONS_TITLE = "Admin notifications";

Future<void> openAdminNotificationsScreen(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  return MyNavigator.pushLimited(context, AdminNotificationPage(r));
}

class AdminNotificationPage extends MyScreenPageLimited<()> {
  AdminNotificationPage(RepositoryInstances r)
    : super(builder: (closer) => AdminNotificationScreen(r, closer: closer));
}

class AdminNotificationScreen extends EditDataScreen<AdminNotificationDataManager> {
  AdminNotificationScreen(RepositoryInstances r, {required super.closer, super.key})
    : super(
        api: r.api,
        dataApi: const AdminNotificationDataApi(),
        title: ADMIN_NOTIFICATIONS_TITLE,
      );
}

class AdminNotificationDataApi extends EditDataApi<AdminNotificationDataManager> {
  const AdminNotificationDataApi();

  @override
  Future<Result<AdminNotificationDataManager, ()>> load(ApiManager api) async {
    final settings = await api.commonAdmin((api) => api.getAdminNotificationSettings()).ok();
    final subscriptions = await api
        .commonAdmin((api) => api.getAdminNotificationSubscriptions())
        .ok();

    if (settings == null || subscriptions == null) {
      return const Err(());
    }

    return Ok(AdminNotificationDataManager(settings, BooleanValuesManager(subscriptions.toJson())));
  }

  @override
  Future<Result<(), String>> save(ApiManager api, AdminNotificationDataManager values) async {
    final subscriptions = AdminNotification.fromJson(values.values.editedState());
    if (subscriptions == null) {
      return const Err("subscriptions == null");
    }

    return await api
        .commonAdminAction((api) => api.postAdminNotificationSettings(values.editedSettings))
        .andThenEmptyErr(
          (_) =>
              api.commonAdminAction((api) => api.postAdminNotificationSubscriptions(subscriptions)),
        )
        .mapErr((_) => "API request failed");
  }
}

class AdminNotificationDataManager extends BaseDataManager
    implements DataManager, BooleanDataManager, WeekdayDataManager {
  final AdminNotificationSettings settings;
  AdminNotificationSettings editedSettings;
  final BooleanValuesManager values;
  AdminNotificationDataManager(this.settings, this.values)
    : editedSettings = AdminNotificationSettings(
        dailyEnabledTimeStartSeconds: settings.dailyEnabledTimeStartSeconds,
        dailyEnabledTimeEndSeconds: settings.dailyEnabledTimeEndSeconds,
        weekdays: settings.weekdays,
      );

  @override
  List<Widget> actions() => [
    BooleanDataDeselectAction(dataManager: this),
    BooleanDataSelectAction(dataManager: this),
  ];

  @override
  String changesText() => "";

  @override
  List<Widget> slivers() => [
    SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsetsGeometry.only(top: 8)),
          hPad(Text("Notification sending weekdays")),
          Padding(padding: EdgeInsetsGeometry.only(top: 8)),
          hPad(WeekdayDataViewer(dataManager: this)),
          Padding(padding: EdgeInsetsGeometry.only(top: 8)),
          hPad(Text("Notification sending daily start and end time")),
          Padding(padding: EdgeInsetsGeometry.only(top: 8)),
          DayTimestampDataViewer(start: StartTimeManager(this), end: EndTimeManager(this)),
          Padding(padding: EdgeInsetsGeometry.only(top: 8)),
        ],
      ),
    ),
    BooleanDataViewerSliver(dataManager: this),
  ];

  @override
  bool unsavedChanges() => values.unsavedChanges() || settings != editedSettings;

  // Weekday

  @override
  int selectedWeekdays() => editedSettings.weekdays;

  @override
  void setWeekdays(int value) => editedSettings.weekdays = value;

  // Boolean

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

class StartTimeManager implements DayTimestampDataManager {
  final AdminNotificationDataManager data;
  StartTimeManager(this.data);

  @override
  BaseDataManager get baseDataManager => data;

  @override
  int currentDayTimestamp() => data.editedSettings.dailyEnabledTimeStartSeconds;

  @override
  void setDayTimestamp(int value) => data.editedSettings.dailyEnabledTimeStartSeconds = value;
}

class EndTimeManager implements DayTimestampDataManager {
  final AdminNotificationDataManager data;
  EndTimeManager(this.data);

  @override
  BaseDataManager get baseDataManager => data;

  @override
  int currentDayTimestamp() => data.editedSettings.dailyEnabledTimeEndSeconds;

  @override
  void setDayTimestamp(int value) => data.editedSettings.dailyEnabledTimeEndSeconds = value;
}
