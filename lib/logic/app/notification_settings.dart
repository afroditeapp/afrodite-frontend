import "dart:async";

import "package:app/localizations.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/general/notification/utils/notification_category.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/notification_manager.dart";
import "package:app/model/freezed/logic/settings/notification_settings.dart";
import "package:openapi/api.dart";

abstract class NotificationSettingsEvent {}

class ReloadNotificationsEnabledStatus extends NotificationSettingsEvent {}
class ResetEditedValues extends NotificationSettingsEvent {}
class SaveSettings extends NotificationSettingsEvent {}
class ToggleMessages extends NotificationSettingsEvent {}
class ToggleLikes extends NotificationSettingsEvent {}
class ToggleMediaContentModerationCompleted extends NotificationSettingsEvent {}
class ToggleProfileTextModerationCompleted extends NotificationSettingsEvent {}
class ToggleNews extends NotificationSettingsEvent {}
class NewValueMessages extends NotificationSettingsEvent {
  final bool value;
  NewValueMessages(this.value);
}
class NewValueLikes extends NotificationSettingsEvent {
  final bool value;
  NewValueLikes(this.value);
}
class NewValueMediaContentModerationCompleted extends NotificationSettingsEvent {
  final bool value;
  NewValueMediaContentModerationCompleted(this.value);
}
class NewValueProfileTextModerationCompleted extends NotificationSettingsEvent {
  final bool value;
  NewValueProfileTextModerationCompleted(this.value);
}
class NewValueNews extends NotificationSettingsEvent {
  final bool value;
  NewValueNews(this.value);
}

class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsData> {
  final api = LoginRepository.getInstance().repositories.api;
  final db = LoginRepository.getInstance().repositories.accountBackgroundDb;
  final notifications = NotificationManager.getInstance();

  StreamSubscription<bool?>? _messagesSubscription;
  StreamSubscription<bool?>? _likesSubscription;
  StreamSubscription<bool?>? _mediaContentModerationCompletedSubscription;
  StreamSubscription<bool?>? _profileTextModerationCompletedSubscription;
  StreamSubscription<bool?>? _newsSubscription;

  NotificationSettingsBloc() : super(NotificationSettingsData()) {
    on<ReloadNotificationsEnabledStatus>((data, emit) async {
      final disabledChannelIds = await notifications.disabledNotificationChannelsIdsOnAndroid();
      emit(state.copyWith(
        areNotificationsEnabled: await notifications.areNotificationsEnabled(),
        categorySystemEnabledLikes: !disabledChannelIds.contains(const NotificationCategoryLikes().id),
        categorySystemEnabledMessages: !disabledChannelIds.contains(const NotificationCategoryMessages().id),
        categorySystemEnabledMediaContentModerationCompleted: !disabledChannelIds.contains(const NotificationCategoryMediaContentModerationCompleted().id),
        categorySystemEnabledProfileTextModerationCompleted: !disabledChannelIds.contains(const NotificationCategoryProfileTextModerationCompleted().id),
        categorySystemEnabledNews: !disabledChannelIds.contains(const NotificationCategoryNewsItemAvailable().id),
      ));
    });
    on<ResetEditedValues>((data, emit) async {
      _resetEditedValues(emit);
    });
    on<SaveSettings>((data, emit) async {
      final currentState = state;

      emit(state.copyWith(
        updateState: const UpdateStarted(),
      ));

      final waitTime = WantedWaitingTimeManager();

      var failureDetected = false;

      emit(state.copyWith(
        updateState: const UpdateInProgress(),
      ));

      {
        final settings = AccountAppNotificationSettings(news: currentState.valueNews());
        final r = await api.accountAction((api) => api.postAccountAppNotificationSettings(settings))
          .andThen((_) => db.accountAction((db) => db.daoLocalNotificationSettings.updateAccountNotificationSettings(settings)));
        if (r.isErr()) {
          failureDetected = true;
        }
      }

      {
        final settings = ProfileAppNotificationSettings(
          automaticProfileSearch: true,
          automaticProfileSearchDistance: false,
          automaticProfileSearchNewProfiles: false,
          automaticProfileSearchFilters: false,
          automaticProfileSearchWeekdays: 0x7F,
          profileTextModeration: currentState.valueProfileText(),
        );
        final r = await api.profileAction((api) => api.postProfileAppNotificationSettings(settings))
          .andThen((_) => db.accountAction((db) => db.daoLocalNotificationSettings.updateProfileNotificationSettings(settings)));
        if (r.isErr()) {
          failureDetected = true;
        }
      }

      {
        final settings = MediaAppNotificationSettings(mediaContentModeration: currentState.valueMediaContent());
        final r = await api.mediaAction((api) => api.postMediaAppNotificationSettings(settings))
          .andThen((_) => db.accountAction((db) => db.daoLocalNotificationSettings.updateMediaNotificationSettings(settings)));
        if (r.isErr()) {
          failureDetected = true;
        }
      }

      {
        final settings = ChatAppNotificationSettings(
          likes: currentState.valueLikes(),
          messages: currentState.valueMessages(),
        );
        final r = await api.chatAction((api) => api.postChatAppNotificationSettings(settings))
          .andThen((_) => db.accountAction((db) => db.daoLocalNotificationSettings.updateChatNotificationSettings(settings)));
        if (r.isErr()) {
          failureDetected = true;
        }
      }

      if (failureDetected) {
        showSnackBar(R.strings.generic_error_occurred);
      }

      await waitTime.waitIfNeeded();

      emit(state.copyWith(
        updateState: const UpdateIdle(),
      ));

      _resetEditedValues(emit);
    });
    on<ToggleMessages>((data, emit) async {
      if (state.editedMessages == null) {
        emit(state.copyWith(
          editedMessages: !state.categoryEnabledMessages,
        ));
      } else {
        emit(state.copyWith(
          editedMessages: null,
        ));
      }
    });
    on<ToggleLikes>((data, emit) async {
      if (state.editedLikes == null) {
        emit(state.copyWith(
          editedLikes: !state.categoryEnabledLikes,
        ));
      } else {
        emit(state.copyWith(
          editedLikes: null,
        ));
      }
    });
    on<ToggleMediaContentModerationCompleted>((data, emit) async {
      if (state.editedMediaContent == null) {
        emit(state.copyWith(
          editedMediaContent: !state.categoryEnabledMediaContentModerationCompleted,
        ));
      } else {
        emit(state.copyWith(
          editedMediaContent: null,
        ));
      }
    });
    on<ToggleProfileTextModerationCompleted>((data, emit) async {
      if (state.editedProfileText == null) {
        emit(state.copyWith(
          editedProfileText: !state.categoryEnabledProfileTextModerationCompleted,
        ));
      } else {
        emit(state.copyWith(
          editedProfileText: null,
        ));
      }
    });
    on<ToggleNews>((data, emit) async {
      if (state.editedNews == null) {
        emit(state.copyWith(
          editedNews: !state.categoryEnabledNews,
        ));
      } else {
        emit(state.copyWith(
          editedNews: null,
        ));
      }
    });
    on<NewValueLikes>((data, emit) =>
      emit(state.copyWith(categoryEnabledLikes: data.value))
    );
    on<NewValueMessages>((data, emit) =>
      emit(state.copyWith(categoryEnabledMessages: data.value))
    );
    on<NewValueMediaContentModerationCompleted>((data, emit) =>
      emit(state.copyWith(categoryEnabledMediaContentModerationCompleted: data.value))
    );
    on<NewValueProfileTextModerationCompleted>((data, emit) =>
      emit(state.copyWith(categoryEnabledProfileTextModerationCompleted: data.value))
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
    _mediaContentModerationCompletedSubscription = db
      .accountStream((db) => db.daoLocalNotificationSettings.watchMediaContentModerationCompleted())
      .listen((state) {
        add(NewValueMediaContentModerationCompleted(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
    _profileTextModerationCompletedSubscription = db
      .accountStream((db) => db.daoLocalNotificationSettings.watchProfileTextModerationCompleted())
      .listen((state) {
        add(NewValueProfileTextModerationCompleted(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
    _newsSubscription = db
      .accountStream((db) => db.daoLocalNotificationSettings.watchNewsItemAvailable())
      .listen((state) {
        add(NewValueNews(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
      });
  }

  void _resetEditedValues(Emitter<NotificationSettingsData> emit) {
    emit(state.copyWith(
      editedMessages: null,
      editedLikes: null,
      editedMediaContent: null,
      editedProfileText: null,
      editedNews: null,
    ));
  }

  @override
  Future<void> close() async {
    await _messagesSubscription?.cancel();
    await _likesSubscription?.cancel();
    await _mediaContentModerationCompletedSubscription?.cancel();
    await _profileTextModerationCompletedSubscription?.cancel();
    await _newsSubscription?.cancel();
    await super.close();
  }
}
