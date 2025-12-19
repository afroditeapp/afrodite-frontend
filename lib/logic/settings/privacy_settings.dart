import "dart:async";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/chat_repository.dart";
import "package:app/data/profile_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/settings/privacy_settings.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/api.dart";
import "package:app/utils/time.dart";

sealed class PrivacySettingsEvent {}

class ResetEdited extends PrivacySettingsEvent {}

class SavePrivacySettings extends PrivacySettingsEvent {}

class ToggleMessageStateDelivered extends PrivacySettingsEvent {}

class ToggleMessageStateSent extends PrivacySettingsEvent {}

class ToggleTypingIndicator extends PrivacySettingsEvent {}

class ToggleLastSeenTime extends PrivacySettingsEvent {}

class ToggleOnlineStatus extends PrivacySettingsEvent {}

class _NewChatPrivacySettings extends PrivacySettingsEvent {
  final ChatPrivacySettings? settings;
  _NewChatPrivacySettings(this.settings);
}

class _NewProfilePrivacySettings extends PrivacySettingsEvent {
  final ProfilePrivacySettings? settings;
  _NewProfilePrivacySettings(this.settings);
}

class PrivacySettingsBloc extends Bloc<PrivacySettingsEvent, PrivacySettingsData>
    with ActionRunner {
  final ChatRepository chat;
  final ProfileRepository profile;
  final ApiManager api;
  final AccountDatabaseManager db;

  StreamSubscription<ChatPrivacySettings?>? _privacySubscription;
  StreamSubscription<ProfilePrivacySettings?>? _profilePrivacySubscription;

  PrivacySettingsBloc(RepositoryInstances r)
    : chat = r.chat,
      profile = r.profile,
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
          ),
        );
      }
    });
    on<_NewProfilePrivacySettings>((data, emit) async {
      final settings = data.settings;
      if (settings != null) {
        emit(
          state.copyWith(lastSeenTime: settings.lastSeenTime, onlineStatus: settings.onlineStatus),
        );
      }
    });
    on<SavePrivacySettings>((data, emit) async {
      final currentState = state;

      emit(state.copyWith(updateState: const UpdateStarted()));

      final waitTime = WantedWaitingTimeManager();

      emit(state.copyWith(updateState: const UpdateInProgress()));

      final chatSettings = ChatPrivacySettings(
        messageStateDelivered: currentState.valueMessageStateDelivered(),
        messageStateSent: currentState.valueMessageStateSent(),
        typingIndicator: currentState.valueTypingIndicator(),
      );
      final profileSettings = ProfilePrivacySettings(
        lastSeenTime: currentState.valueLastSeenTime(),
        onlineStatus: currentState.valueOnlineStatus(),
      );
      final chatResult = await api.chatAction((api) => api.postChatPrivacySettings(chatSettings));
      final profileResult = await api.profileAction(
        (api) => api.postProfilePrivacySettings(profileSettings),
      );
      if (chatResult.isOk()) {
        await db.accountAction((db) => db.privacy.updateChatPrivacySettings(chatSettings));
      }
      if (profileResult.isOk()) {
        await db.accountAction(
          (db) => db.profilePrivacy.updateProfilePrivacySettings(profileSettings),
        );
      }
      if (chatResult.isErr() || profileResult.isErr()) {
        showSnackBar(R.strings.generic_error_occurred);
      }

      await waitTime.waitIfNeeded();

      emit(state.copyWith(updateState: const UpdateIdle()));

      if (chatResult.isOk() && profileResult.isOk()) {
        // If online status is being disabled, also disable last seen time filter
        if (profileSettings.onlineStatus == false) {
          final currentFilters = await db
              .accountStream((db) => db.search.watchProfileFilters())
              .first;
          if (currentFilters?.lastSeenTimeFilter?.value == -1) {
            await profile.updateProfileFilters(
              currentFilters?.currentFiltersCopy() ?? {},
              null, // Set lastSeenTimeFilter to null to disable it
              currentFilters?.unlimitedLikesFilter,
              currentFilters?.minDistanceKmFilter,
              currentFilters?.maxDistanceKmFilter,
              currentFilters?.profileCreatedFilter,
              currentFilters?.profileEditedFilter,
              currentFilters?.profileTextMinCharactersFilter,
              currentFilters?.profileTextMaxCharactersFilter,
              currentFilters?.randomProfileOrder ?? false,
            );
            await profile.resetMainProfileIterator();
          }
        }

        emit(
          state.copyWith(
            lastSeenTime: profileSettings.lastSeenTime,
            onlineStatus: profileSettings.onlineStatus,
            edited: EditedPrivacySettingsData(),
          ),
        );
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
    on<ToggleLastSeenTime>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.lastSeenTime == null,
        () => state.edited.copyWith(lastSeenTime: !state.lastSeenTime),
        () => state.edited.copyWith(lastSeenTime: null),
      );
    });
    on<ToggleOnlineStatus>((data, emit) async {
      _updateEditedValue(
        emit,
        () => state.edited.onlineStatus == null,
        () => state.edited.copyWith(onlineStatus: !state.onlineStatus),
        () => state.edited.copyWith(onlineStatus: null),
      );
    });

    _privacySubscription = db.accountStream((db) => db.privacy.watchChatPrivacySettings()).listen((
      settings,
    ) {
      add(_NewChatPrivacySettings(settings));
    });
    _profilePrivacySubscription = db
        .accountStream((db) => db.profilePrivacy.watchProfilePrivacySettings())
        .listen((settings) {
          add(_NewProfilePrivacySettings(settings));
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
    await _profilePrivacySubscription?.cancel();
    await super.close();
  }
}
