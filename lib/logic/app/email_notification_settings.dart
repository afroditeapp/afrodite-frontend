import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_background_database_manager.dart";
import "package:app/localizations.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/time.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/model/freezed/logic/settings/email_notification_settings.dart";
import "package:openapi/api.dart";

abstract class EmailNotificationSettingsEvent {}

class ReloadEmailNotifications extends EmailNotificationSettingsEvent {}

class ResetEditedEmailValues extends EmailNotificationSettingsEvent {}

class SaveEmailSettings extends EmailNotificationSettingsEvent {}

class ToggleEmailMessages extends EmailNotificationSettingsEvent {}

class ToggleEmailLikes extends EmailNotificationSettingsEvent {}

class EmailNotificationSettingsBloc
    extends Bloc<EmailNotificationSettingsEvent, EmailNotificationSettingsData> {
  final ApiManager api;
  final AccountBackgroundDatabaseManager db;

  EmailNotificationSettingsBloc(RepositoryInstances r)
    : api = r.api,
      db = r.accountBackgroundDb,
      super(
        EmailNotificationSettingsData(
          categories: EmailNotificationCategoryData(),
          edited: EditedEmailNotificationSettingsData(),
        ),
      ) {
    on<ReloadEmailNotifications>((data, emit) async {
      final result = await api.chat((api) => api.getChatEmailNotificationSettings());
      final ChatEmailNotificationSettings? settings = result.ok();
      if (settings != null) {
        emit(
          state.copyWith(
            categories: EmailNotificationCategoryData(
              messages: settings.messages,
              likes: settings.likes,
            ),
            edited: EditedEmailNotificationSettingsData(),
          ),
        );
      }
    });
    on<ResetEditedEmailValues>((data, emit) async {
      emit(state.copyWith(edited: EditedEmailNotificationSettingsData()));
    });
    on<SaveEmailSettings>((data, emit) async {
      final currentState = state;

      emit(state.copyWith(updateState: const UpdateStarted()));

      final waitTime = WantedWaitingTimeManager();

      emit(state.copyWith(updateState: const UpdateInProgress()));

      final settings = ChatEmailNotificationSettings(
        likes: currentState.valueLikes(),
        messages: currentState.valueMessages(),
      );
      final r = await api.chatAction((api) => api.postChatEmailNotificationSettings(settings));
      if (r.isErr()) {
        showSnackBar(R.strings.generic_error_occurred);
      }

      await waitTime.waitIfNeeded();

      emit(state.copyWith(updateState: const UpdateIdle()));

      state.copyWith(
        categories: EmailNotificationCategoryData(
          messages: settings.messages,
          likes: settings.likes,
        ),
        edited: EditedEmailNotificationSettingsData(),
      );
    });
    on<ToggleEmailMessages>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.messages == null,
        () => state.edited.copyWith(messages: !state.categories.messages),
        () => state.edited.copyWith(messages: null),
      );
    });
    on<ToggleEmailLikes>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.likes == null,
        () => state.edited.copyWith(likes: !state.categories.likes),
        () => state.edited.copyWith(likes: null),
      );
    });
  }

  void _updateEditedValue(
    Emitter<EmailNotificationSettingsData> emit,
    bool Function() shouldUpdate,
    EditedEmailNotificationSettingsData Function() update,
    EditedEmailNotificationSettingsData Function() reset,
  ) {
    final EditedEmailNotificationSettingsData edited;
    if (shouldUpdate()) {
      edited = update();
    } else {
      edited = reset();
    }
    emit(state.copyWith(edited: edited));
  }
}
