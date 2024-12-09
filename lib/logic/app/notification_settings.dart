import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/general/notification/utils/notification_category.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/notification_manager.dart";
import "package:app/model/freezed/logic/settings/notification_settings.dart";

abstract class NotificationSettingsEvent {}

class ReloadNotificationsEnabledStatus extends NotificationSettingsEvent {}
class ToggleMessages extends NotificationSettingsEvent {}
class ToggleLikes extends NotificationSettingsEvent {}
class ToggleInitialContentModeration extends NotificationSettingsEvent {}
class ToggleNews extends NotificationSettingsEvent {}
class NewValueMessages extends NotificationSettingsEvent {
  final bool value;
  NewValueMessages(this.value);
}
class NewValueLikes extends NotificationSettingsEvent {
  final bool value;
  NewValueLikes(this.value);
}
class NewValueInitialContentModeration extends NotificationSettingsEvent {
  final bool value;
  NewValueInitialContentModeration(this.value);
}
class NewValueNews extends NotificationSettingsEvent {
  final bool value;
  NewValueNews(this.value);
}

class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsData> {
  final db = LoginRepository.getInstance().repositories.accountBackgroundDb;
  final notifications = NotificationManager.getInstance();

  StreamSubscription<bool?>? _messagesSubscription;
  StreamSubscription<bool?>? _likesSubscription;
  StreamSubscription<bool?>? _initialContentModerationSubscription;
  StreamSubscription<bool?>? _newsSubscription;

  NotificationSettingsBloc() : super(NotificationSettingsData()) {
    on<ReloadNotificationsEnabledStatus>((data, emit) async {
      final disabledChannelIds = await notifications.disabledNotificationChannelsIdsOnAndroid();
      emit(state.copyWith(
        areNotificationsEnabled: await notifications.areNotificationsEnabled(),
        categorySystemEnabledLikes: !disabledChannelIds.contains(const NotificationCategoryLikes().id),
        categorySystemEnabledMessages: !disabledChannelIds.contains(const NotificationCategoryMessages().id),
        categorySystemEnabledInitialContentModeration: !disabledChannelIds.contains(const NotificationCategoryInitialContentModeration().id),
        categorySystemEnabledNews: !disabledChannelIds.contains(const NotificationCategoryNewsItemAvailable().id),
      ));
    });
    on<ToggleMessages>((data, emit) async {
      await db.accountAction((db) => db.daoLocalNotificationSettings.updateMessages(!state.categoryEnabledMessages));
    });
    on<ToggleLikes>((data, emit) async {
      await db.accountAction((db) => db.daoLocalNotificationSettings.updateLikes(!state.categoryEnabledLikes));
    });
    on<ToggleInitialContentModeration>((data, emit) async {
      await db.accountAction((db) => db.daoLocalNotificationSettings.updateInitialContentModeration(!state.categoryEnabledInitialContentModeration));
    });
    on<ToggleNews>((data, emit) async {
      await db.accountAction((db) => db.daoLocalNotificationSettings.updateNews(!state.categoryEnabledNews));
    });
    on<NewValueLikes>((data, emit) =>
      emit(state.copyWith(categoryEnabledLikes: data.value))
    );
    on<NewValueMessages>((data, emit) =>
      emit(state.copyWith(categoryEnabledMessages: data.value))
    );
    on<NewValueInitialContentModeration>((data, emit) =>
      emit(state.copyWith(categoryEnabledInitialContentModeration: data.value))
    );
    on<NewValueNews>((data, emit) =>
      emit(state.copyWith(categoryEnabledNews: data.value))
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
    _initialContentModerationSubscription = db
      .accountStream((db) => db.daoLocalNotificationSettings.watchInitialContentModeration())
      .listen((state) {
        add(NewValueInitialContentModeration(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
    _newsSubscription = db
      .accountStream((db) => db.daoLocalNotificationSettings.watchNewsItemAvailable())
      .listen((state) {
        add(NewValueNews(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
  }

  @override
  Future<void> close() async {
    await _messagesSubscription?.cancel();
    await _likesSubscription?.cancel();
    await _initialContentModerationSubscription?.cancel();
    await _newsSubscription?.cancel();
    await super.close();
  }
}
