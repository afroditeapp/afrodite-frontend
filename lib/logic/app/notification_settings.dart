import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/general/notification/utils/notification_category.dart";
import "package:pihka_frontend/data/notification_manager.dart";
import "package:pihka_frontend/database/background_database_manager.dart";
import "package:pihka_frontend/model/freezed/logic/settings/notification_settings.dart";

abstract class NotificationSettingsEvent {}

class ReloadNotificationsEnabledStatus extends NotificationSettingsEvent {}
class ToggleMessages extends NotificationSettingsEvent {}
class ToggleLikes extends NotificationSettingsEvent {}
class ToggleModerationRequestStatus extends NotificationSettingsEvent {}
class NewValueMessages extends NotificationSettingsEvent {
  final bool value;
  NewValueMessages(this.value);
}
class NewValueLikes extends NotificationSettingsEvent {
  final bool value;
  NewValueLikes(this.value);
}
class NewValueModerationRequestState extends NotificationSettingsEvent {
  final bool value;
  NewValueModerationRequestState(this.value);
}

class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsData> {
  final db = BackgroundDatabaseManager.getInstance();
  final notifications = NotificationManager.getInstance();

  StreamSubscription<bool?>? _messagesSubscription;
  StreamSubscription<bool?>? _likesSubscription;
  StreamSubscription<bool?>? _moderationRequestStatusSubscription;

  NotificationSettingsBloc() : super(NotificationSettingsData()) {
    on<ReloadNotificationsEnabledStatus>((data, emit) async {
      final disabledChannelIds = await notifications.disabledNotificationChannelsIdsOnAndroid();
      emit(state.copyWith(
        areNotificationsEnabled: await notifications.areNotificationsEnabled(),
        categorySystemEnabledLikes: !disabledChannelIds.contains(const NotificationCategoryLikes().id),
        categorySystemEnabledMessages: !disabledChannelIds.contains(const NotificationCategoryMessages().id),
        categorySystemEnabledModerationRequestStatus: !disabledChannelIds.contains(const NotificationCategoryModerationRequestStatus().id),
      ));
    });
    on<ToggleMessages>((data, emit) async {
      await db.accountAction((db) => db.daoLocalNotificationSettings.updateMessages(!state.categoryEnabledMessages));
    });
    on<ToggleLikes>((data, emit) async {
      await db.accountAction((db) => db.daoLocalNotificationSettings.updateLikes(!state.categoryEnabledLikes));
    });
    on<ToggleModerationRequestStatus>((data, emit) async {
      await db.accountAction((db) => db.daoLocalNotificationSettings.updateModerationRequestStatus(!state.categoryEnabledModerationRequestStatus));
    });
    on<NewValueLikes>((data, emit) =>
      emit(state.copyWith(categoryEnabledLikes: data.value))
    );
    on<NewValueMessages>((data, emit) =>
      emit(state.copyWith(categoryEnabledMessages: data.value))
    );
    on<NewValueModerationRequestState>((data, emit) =>
      emit(state.copyWith(categoryEnabledModerationRequestStatus: data.value))
    );

    _messagesSubscription = db
      .accountStream((db) => db.daoLocalNotificationSettings.watchMessages())
      .listen((state) {
        add(NewValueMessages(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
    _likesSubscription = db
      .accountStream((db) => db.daoLocalNotificationSettings.watchLikes())
      .listen((state) {
        add(NewValueLikes(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
    _moderationRequestStatusSubscription = db
      .accountStream((db) => db.daoLocalNotificationSettings.watchModerationRequestStatus())
      .listen((state) {
        add(NewValueModerationRequestState(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
  }

  @override
  Future<void> close() async {
    await _messagesSubscription?.cancel();
    await _likesSubscription?.cancel();
    await _moderationRequestStatusSubscription?.cancel();
    await super.close();
  }
}
