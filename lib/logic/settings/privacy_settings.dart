import "dart:async";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/chat_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/settings/privacy_settings.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/time.dart";

sealed class PrivacySettingsEvent {}

class ResetEdited extends PrivacySettingsEvent {}

class SavePrivacySettings extends PrivacySettingsEvent {}

class ToggleMessageStateDelivered extends PrivacySettingsEvent {}

class ToggleMessageStateSent extends PrivacySettingsEvent {}

class ToggleTypingIndicator extends PrivacySettingsEvent {}

class _NewChatPrivacySettings extends PrivacySettingsEvent {
  final ChatPrivacySettings? settings;
  _NewChatPrivacySettings(this.settings);
}

class PrivacySettingsBloc extends Bloc<PrivacySettingsEvent, PrivacySettingsData>
    with ActionRunner {
  final ChatRepository chat;
  final ApiManager api;
  final AccountDatabaseManager db;

  StreamSubscription<ChatPrivacySettings?>? _privacySubscription;

  PrivacySettingsBloc(RepositoryInstances r)
    : chat = r.chat,
      api = r.api,
      db = r.accountDb,
      super(PrivacySettingsData(edited: EditedPrivacySettingsData())) {
    on<ResetEdited>((data, emit) {
      emit(state.copyWith(edited: EditedPrivacySettingsData()));
    });
    on<_NewChatPrivacySettings>((data, emit) async {
      final settings = data.settings;
      if (settings != null) {
        emit(
          state.copyWith(
            messageStateDelivered: settings.messageStateDelivered,
            messageStateSent: settings.messageStateSent,
            typingIndicator: settings.typingIndicator,
            edited: EditedPrivacySettingsData(),
          ),
        );
      }
    });
    on<SavePrivacySettings>((data, emit) async {
      final currentState = state;

      emit(state.copyWith(updateState: const UpdateStarted()));

      final waitTime = WantedWaitingTimeManager();

      emit(state.copyWith(updateState: const UpdateInProgress()));

      final settings = ChatPrivacySettings(
        messageStateDelivered: currentState.valueMessageStateDelivered(),
        messageStateSent: currentState.valueMessageStateSent(),
        typingIndicator: currentState.valueTypingIndicator(),
      );
      final r = await api.chatAction((api) => api.postChatPrivacySettings(settings));
      if (r.isOk()) {
        await db.accountAction((db) => db.privacy.updateChatPrivacySettings(settings));
      } else {
        showSnackBar(R.strings.generic_error_occurred);
      }

      await waitTime.waitIfNeeded();

      emit(state.copyWith(updateState: const UpdateIdle()));

      if (r.isOk()) {
        emit(state.copyWith(edited: EditedPrivacySettingsData()));
      }
    });
    on<ToggleMessageStateDelivered>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.messageStateDelivered == null,
        () => state.edited.copyWith(messageStateDelivered: !state.messageStateDelivered),
        () => state.edited.copyWith(messageStateDelivered: null),
      );
    });
    on<ToggleMessageStateSent>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.messageStateSent == null,
        () => state.edited.copyWith(messageStateSent: !state.messageStateSent),
        () => state.edited.copyWith(messageStateSent: null),
      );
    });
    on<ToggleTypingIndicator>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.typingIndicator == null,
        () => state.edited.copyWith(typingIndicator: !state.typingIndicator),
        () => state.edited.copyWith(typingIndicator: null),
      );
    });

    _privacySubscription = db.accountStream((db) => db.privacy.watchChatPrivacySettings()).listen((
      settings,
    ) {
      add(_NewChatPrivacySettings(settings));
    });
  }

  void _updateEditedValue(
    Emitter<PrivacySettingsData> emit,
    bool Function() shouldUpdate,
    EditedPrivacySettingsData Function() update,
    EditedPrivacySettingsData Function() reset,
  ) {
    final EditedPrivacySettingsData edited;
    if (shouldUpdate()) {
      edited = update();
    } else {
      edited = reset();
    }
    emit(state.copyWith(edited: edited));
  }

  @override
  Future<void> close() async {
    await _privacySubscription?.cancel();
    await super.close();
  }
}
