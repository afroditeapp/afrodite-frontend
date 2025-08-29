import "dart:async";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_background_database_manager.dart";
import "package:app/localizations.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/general/notification/utils/notification_category.dart";
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

class ToggleProfileStringModerationCompleted extends NotificationSettingsEvent {}

class ToggleNews extends NotificationSettingsEvent {}

class ToggleAutomaticProfileSearch extends NotificationSettingsEvent {}

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

class NewValueNews extends NotificationSettingsEvent {
  final bool value;
  NewValueNews(this.value);
}

class NewValueProfileSettings extends NotificationSettingsEvent {
  final ProfileAppNotificationSettings value;
  NewValueProfileSettings(this.value);
}

class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsData> {
  final ApiManager api;
  final AccountBackgroundDatabaseManager db;
  final notifications = NotificationManager.getInstance();

  StreamSubscription<bool?>? _messagesSubscription;
  StreamSubscription<bool?>? _likesSubscription;
  StreamSubscription<bool?>? _mediaContentModerationCompletedSubscription;
  StreamSubscription<bool?>? _newsSubscription;

  NotificationSettingsBloc(RepositoryInstances r)
    : api = r.api,
      db = r.accountBackgroundDb,
      super(
        NotificationSettingsData(
          categories: NotificationCategoryData(),
          systemCategories: NotificationCategoryData(),
          edited: EditedNotificationSettingsData(),
        ),
      ) {
    on<ReloadNotificationsEnabledStatus>((data, emit) async {
      final disabledChannelIds = await notifications.disabledNotificationChannelsIdsOnAndroid();
      emit(
        state.copyWith(
          areNotificationsEnabled: await notifications.areNotificationsEnabled(),
          systemCategories: NotificationCategoryData(
            likes: !disabledChannelIds.contains(const NotificationCategoryLikes().id),
            messages: !disabledChannelIds.contains(const NotificationCategoryMessages().id),
            mediaContentModerationCompleted: !disabledChannelIds.contains(
              const NotificationCategoryMediaContentModerationCompleted().id,
            ),
            profileStringModerationCompleted: !disabledChannelIds.contains(
              const NotificationCategoryProfileStringModerationCompleted().id,
            ),
            news: !disabledChannelIds.contains(const NotificationCategoryNewsItemAvailable().id),
            automaticProfileSearch: !disabledChannelIds.contains(
              const NotificationCategoryAutomaticProfileSearch().id,
            ),
          ),
        ),
      );
    });
    on<ResetEditedValues>((data, emit) async {
      _resetEditedValues(emit);
    });
    on<SaveSettings>((data, emit) async {
      final currentState = state;

      emit(state.copyWith(updateState: const UpdateStarted()));

      final waitTime = WantedWaitingTimeManager();

      var failureDetected = false;

      emit(state.copyWith(updateState: const UpdateInProgress()));

      {
        final settings = AccountAppNotificationSettings(news: currentState.valueNews());
        final r = await api
            .accountAction((api) => api.postAccountAppNotificationSettings(settings))
            .andThen(
              (_) => db.accountAction(
                (db) => db.appNotificationSettings.updateAccountNotificationSettings(settings),
              ),
            );
        if (r.isErr()) {
          failureDetected = true;
        }
      }

      {
        final settings = ProfileAppNotificationSettings(
          profileStringModeration: currentState.valueProfileString(),
          automaticProfileSearch: currentState.valueAutomaticProfileSearch(),
        );
        final r = await api
            .profileAction((api) => api.postProfileAppNotificationSettings(settings))
            .andThen(
              (_) => db.accountAction(
                (db) => db.appNotificationSettings.updateProfileNotificationSettings(settings),
              ),
            );
        if (r.isErr()) {
          failureDetected = true;
        }
      }

      {
        final settings = MediaAppNotificationSettings(
          mediaContentModeration: currentState.valueMediaContent(),
        );
        final r = await api
            .mediaAction((api) => api.postMediaAppNotificationSettings(settings))
            .andThen(
              (_) => db.accountAction(
                (db) => db.appNotificationSettings.updateMediaNotificationSettings(settings),
              ),
            );
        if (r.isErr()) {
          failureDetected = true;
        }
      }

      {
        final settings = ChatAppNotificationSettings(
          likes: currentState.valueLikes(),
          messages: currentState.valueMessages(),
        );
        final r = await api
            .chatAction((api) => api.postChatAppNotificationSettings(settings))
            .andThen(
              (_) => db.accountAction(
                (db) => db.appNotificationSettings.updateChatNotificationSettings(settings),
              ),
            );
        if (r.isErr()) {
          failureDetected = true;
        }
      }

      if (failureDetected) {
        showSnackBar(R.strings.generic_error_occurred);
      }

      await waitTime.waitIfNeeded();

      emit(state.copyWith(updateState: const UpdateIdle()));

      _resetEditedValues(emit);
    });
    on<ToggleMessages>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.messages == null,
        () => state.edited.copyWith(messages: !state.categories.messages),
        () => state.edited.copyWith(messages: null),
      );
    });
    on<ToggleLikes>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.likes == null,
        () => state.edited.copyWith(likes: !state.categories.likes),
        () => state.edited.copyWith(likes: null),
      );
    });
    on<ToggleMediaContentModerationCompleted>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.mediaContent == null,
        () =>
            state.edited.copyWith(mediaContent: !state.categories.mediaContentModerationCompleted),
        () => state.edited.copyWith(mediaContent: null),
      );
    });
    on<ToggleProfileStringModerationCompleted>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.profileString == null,
        () => state.edited.copyWith(
          profileString: !state.categories.profileStringModerationCompleted,
        ),
        () => state.edited.copyWith(profileString: null),
      );
    });
    on<ToggleNews>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.news == null,
        () => state.edited.copyWith(news: !state.categories.news),
        () => state.edited.copyWith(news: null),
      );
    });
    on<ToggleAutomaticProfileSearch>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.automaticProfileSearch == null,
        () =>
            state.edited.copyWith(automaticProfileSearch: !state.categories.automaticProfileSearch),
        () => state.edited.copyWith(automaticProfileSearch: null),
      );
    });
    on<NewValueLikes>(
      (data, emit) =>
          emit(state.copyWith(categories: state.categories.copyWith(likes: data.value))),
    );
    on<NewValueMessages>(
      (data, emit) =>
          emit(state.copyWith(categories: state.categories.copyWith(messages: data.value))),
    );
    on<NewValueMediaContentModerationCompleted>(
      (data, emit) => emit(
        state.copyWith(
          categories: state.categories.copyWith(mediaContentModerationCompleted: data.value),
        ),
      ),
    );
    on<NewValueNews>(
      (data, emit) => emit(state.copyWith(categories: state.categories.copyWith(news: data.value))),
    );
    on<NewValueProfileSettings>((data, emit) {
      final v = data.value;
      emit(
        state.copyWith(
          categories: state.categories.copyWith(
            profileStringModerationCompleted: v.profileStringModeration,
          ),
        ),
      );
    });

    _messagesSubscription = db
        .accountStream((db) => db.appNotificationSettings.watchMessages())
        .listen((state) {
          add(NewValueMessages(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
        });
    _likesSubscription = db.accountStream((db) => db.appNotificationSettings.watchLikes()).listen((
      state,
    ) {
      add(NewValueLikes(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
    });
    _mediaContentModerationCompletedSubscription = db
        .accountStream((db) => db.appNotificationSettings.watchMediaContentModerationCompleted())
        .listen((state) {
          add(
            NewValueMediaContentModerationCompleted(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT),
          );
        });
    _newsSubscription = db.accountStream((db) => db.appNotificationSettings.watchNews()).listen((
      state,
    ) {
      add(NewValueNews(state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT));
    });
  }

  void _resetEditedValues(Emitter<NotificationSettingsData> emit) {
    emit(state.copyWith(edited: EditedNotificationSettingsData()));
  }

  void _updateEditedValue(
    Emitter<NotificationSettingsData> emit,
    bool Function() shouldUpdate,
    EditedNotificationSettingsData Function() update,
    EditedNotificationSettingsData Function() reset,
  ) {
    final EditedNotificationSettingsData edited;
    if (shouldUpdate()) {
      edited = update();
    } else {
      edited = reset();
    }
    emit(state.copyWith(edited: edited));
  }

  @override
  Future<void> close() async {
    await _messagesSubscription?.cancel();
    await _likesSubscription?.cancel();
    await _mediaContentModerationCompletedSubscription?.cancel();
    await _newsSubscription?.cancel();
    await super.close();
  }
}
