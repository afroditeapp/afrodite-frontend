
import 'package:app/api/api_manager.dart';
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
    final settings = await api
      .commonAdmin(
        (api) => api.getAdminNotificationSettings(),
      ).ok();
    final subscriptions = await api
      .commonAdmin(
        (api) => api.getAdminNotificationSubscriptions(),
      ).ok();

    if (settings == null || subscriptions == null) {
      return const Err(());
    }

    return Ok(AdminNotificationDataManager(
      settings,
      BooleanValuesManager(subscriptions.toJson()),
    ));
  }

  @override
  Future<Result<(), String>> save(ApiManager api, AdminNotificationDataManager values) async {
    final subscriptions = AdminNotification.fromJson(values.values.editedState());
    if (subscriptions == null) {
      return const Err("subscriptions == null");
    }

    if (values.editedSettings.dailyEnabledTimeEndSeconds > values.editedSettings.dailyEnabledTimeStartSeconds) {
      return const Err("end time is smaller than start time");
    }

    return await api
      .commonAdminAction(
        (api) => api.postAdminNotificationSettings(values.editedSettings)
      )
      .andThenEmptyErr((_) => api
        .commonAdminAction(
          (api) => api.postAdminNotificationSubscriptions(subscriptions)
        )
      ).mapErr((_) => "API request failed");
  }
}

class AdminNotificationDataManager extends BaseDataManager implements DataManager, BooleanDataManager, WeekdayDataManager  {
  final AdminNotificationSettings settings;
  AdminNotificationSettings editedSettings;
  final BooleanValuesManager values;
  AdminNotificationDataManager(this.settings, this.values) :
    editedSettings = AdminNotificationSettings(
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
          hPad(Text("Notification sending daily start and end time (UTC+0)")),
          hPad(Row(
            spacing: 8,
            children: [
              DayTimestampDataViewer(dataManager: StartTimeManager(this)),
              DayTimestampDataViewer(dataManager: EndTimeManager(this))
            ]
          )),
        ],
      )
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
