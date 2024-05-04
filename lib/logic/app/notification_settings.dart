import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/notification_manager.dart";
import "package:pihka_frontend/database/database_manager.dart";
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
  final db = DatabaseManager.getInstance();

  NotificationSettingsBloc() : super(NotificationSettingsData()) {
    on<ReloadNotificationsEnabledStatus>((data, emit) async {
      final notificationsEnabled = await NotificationManager.getInstance().areNotificationsEnabled();
      emit(state.copyWith(areNotificationsEnabled: notificationsEnabled));
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

    db
      .accountStream((db) => db.daoLocalNotificationSettings.watchMessages())
      .listen((state) {
        add(NewValueMessages(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
    db
      .accountStream((db) => db.daoLocalNotificationSettings.watchLikes())
      .listen((state) {
        add(NewValueLikes(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
    db
      .accountStream((db) => db.daoLocalNotificationSettings.watchModerationRequestStatus())
      .listen((state) {
        add(NewValueModerationRequestState(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
  }
}
