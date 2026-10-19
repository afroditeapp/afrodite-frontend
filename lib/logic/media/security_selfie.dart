import "dart:async";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/account_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/media/security_selfie.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/profile_pictures.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/model.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";

sealed class SecuritySelfieEvent {}

class DbSecurityContent extends SecuritySelfieEvent {
  final MyContent? content;
  DbSecurityContent(this.content);
}

class DbDataConsentSettings extends SecuritySelfieEvent {
  final DataConsentSettings? settings;
  DbDataConsentSettings(this.settings);
}

class EditSecurityContent extends SecuritySelfieEvent {
  final AccountImageId? content;
  EditSecurityContent(this.content);
}

class EditAllowFaceVerification extends SecuritySelfieEvent {
  final bool value;
  EditAllowFaceVerification(this.value);
}

class ResetEditedValues extends SecuritySelfieEvent {}

class RefreshDataConsentSettingsSilently extends SecuritySelfieEvent {}

class SaveSecurityContentScreenChanges extends SecuritySelfieEvent {}

class SecuritySelfieBloc extends Bloc<SecuritySelfieEvent, SecuritySelfieData> with ActionRunner {
  final AccountDatabaseManager db;
  final AccountRepository account;
  final MediaRepository media;
  final AccountId currentUser;
  final ApiManager api;

  StreamSubscription<MyContent?>? _securityContentSubscription;
  StreamSubscription<DataConsentSettings?>? _dataConsentSettingsSubscription;

  SecuritySelfieBloc(RepositoryInstances r)
    : db = r.accountDb,
      account = r.account,
      media = r.media,
      currentUser = r.accountId,
      api = r.api,
      super(SecuritySelfieData(edited: EditedSecuritySelfieData())) {
    on<DbSecurityContent>((data, emit) {
      emit(state.copyWith(securityContent: data.content));
    });
    on<DbDataConsentSettings>((data, emit) {
      emit(state.copyWith(dataConsentSettings: data.settings));
    });
    on<EditSecurityContent>((data, emit) {
      final current = state.currentSecurityContent;
      modifyEdited(
        emit,
        (e) => current == data.content?.contentId
            ? e.copyWith(securityContent: const NoEdit())
            : e.copyWith(securityContent: editValue(data.content)),
      );
    });
    on<EditAllowFaceVerification>((data, emit) {
      final current = state.dataConsentSettings?.allowFaceVerification ?? false;
      modifyEdited(
        emit,
        (e) => current == data.value
            ? e.copyWith(allowFaceVerification: null)
            : e.copyWith(allowFaceVerification: data.value),
      );
    });
    on<ResetEditedValues>((data, emit) {
      emit(state.copyWith(edited: EditedSecuritySelfieData()));
    });
    on<RefreshDataConsentSettingsSilently>((data, emit) async {
      await Future<void>.delayed(const Duration(seconds: 2));
      final settings = await api.common((api) => api.getDataConsentSettings()).ok();
      if (settings != null) {
        emit(state.copyWith(dataConsentSettings: settings));
      }
    });
    on<SaveSecurityContentScreenChanges>((data, emit) async {
      await runOnce(() async {
        var failureDetected = false;

        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        emit(state.copyWith(updateState: const UpdateInProgress()));

        final s = state;

        final selectedSecurityContent = s.valueSecurityContent(currentUser);
        if (selectedSecurityContent != null && s.edited.securityContent.unsavedChanges()) {
          final changeResult = await api.mediaAction(
            (api) => api.putSecurityContentInfo(selectedSecurityContent.contentId),
          );
          final updateResult = await media.reloadMyMediaContent();
          if (changeResult.isErr() || updateResult.isErr()) {
            failureDetected = true;
          }
        }

        final allowFaceVerification = s.edited.allowFaceVerification;
        if (allowFaceVerification != null && !failureDetected) {
          final settings = UpdateDataConsentSettings(allowFaceVerification: allowFaceVerification);
          final changeResult = await api.commonAction(
            (api) => api.postDataConsentSettings(settings),
          );
          if (changeResult.isOk()) {
            await db.accountAction(
              (db) => db.common.updateDataConsentSettings(
                DataConsentSettings(allowFaceVerification: allowFaceVerification),
              ),
            );
          } else {
            failureDetected = true;
            await account.reloadDataConsentSettings();
          }
        }

        await waitTime.waitIfNeeded();

        emit(state.copyWith(updateState: UpdateIdle(updateFailed: failureDetected)));

        if (failureDetected) {
          showSnackBar(R.strings.generic_error_occurred);
        } else {
          showSnackBar(R.strings.generic_changes_saved);
          resetEditedValues(emit);
        }
      });
    });

    _securityContentSubscription = db
        .accountStream((db) => db.myMedia.watchMyCurrentSecurityContent())
        .listen((event) {
          add(DbSecurityContent(event));
        });
    _dataConsentSettingsSubscription = db
        .accountStream((db) => db.common.watchDataConsentSettings())
        .listen((event) {
          add(DbDataConsentSettings(event));
        });
  }

  void resetEditedValues(Emitter<SecuritySelfieData> emit) {
    emit(state.copyWith(edited: EditedSecuritySelfieData()));
  }

  void modifyEdited(
    Emitter<SecuritySelfieData> emit,
    EditedSecuritySelfieData Function(EditedSecuritySelfieData) modify,
  ) {
    emit(state.copyWith(edited: modify(state.edited)));
  }

  @override
  Future<void> close() async {
    await _securityContentSubscription?.cancel();
    await _dataConsentSettingsSubscription?.cancel();
    await super.close();
  }
}
