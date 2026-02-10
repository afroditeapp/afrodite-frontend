import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:database_converter/database_converter.dart';
import 'package:drift/drift.dart';
import 'package:database_model/database_model.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'progress.g.dart';

@DriftAccessor(
  tables: [schema.InitialSetupProgress, schema.EditProfileProgress, schema.DraftMessage],
)
class DaoWriteProgress extends DatabaseAccessor<AccountDatabase> with _$DaoWriteProgressMixin {
  DaoWriteProgress(super.db);

  // Initial setup progress updates
  Future<void> updateInitialSetupEmail(String? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, email: Value(value)),
    );
  }

  Future<void> updateInitialSetupIsAdult(bool? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, isAdult: Value(value)),
    );
  }

  Future<void> updateInitialSetupProfileName(String? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, profileName: Value(value)),
    );
  }

  Future<void> updateInitialSetupProfileAge(int? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, profileAge: Value(value)),
    );
  }

  Future<void> updateInitialSetupSecuritySelfie({String? contentId, bool? faceDetected}) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        securitySelfieContentId: Value(contentId),
        securitySelfieFaceDetected: Value(faceDetected),
      ),
    );
  }

  Future<void> updateInitialSetupProfileImages(List<ProfilePictureEntry> images) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileImages: Value(images.toJsonList()),
      ),
    );
  }

  Future<void> updateInitialSetupGender(String? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, gender: Value(value)),
    );
  }

  Future<void> updateInitialSetupGenderSearchSettings({
    bool? men,
    bool? women,
    bool? nonBinary,
  }) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        searchSettingMen: Value(men),
        searchSettingWomen: Value(women),
        searchSettingNonBinary: Value(nonBinary),
      ),
    );
  }

  Future<void> updateInitialSetupSearchAgeRange({bool? initDone, int? min, int? max}) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        searchAgeRangeInitDone: Value(initDone),
        searchAgeRangeMin: Value(min),
        searchAgeRangeMax: Value(max),
      ),
    );
  }

  Future<void> updateInitialSetupLocation(double? latitude, double? longitude) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        latitude: Value(latitude),
        longitude: Value(longitude),
      ),
    );
  }

  Future<void> updateInitialSetupProfileAttributes(
    List<api.ProfileAttributeValueUpdate>? attributes,
  ) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileAttributes: Value(attributes?.toJsonList()),
      ),
    );
  }

  Future<void> updateInitialSetupCurrentPage(String pageName) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, currentPage: Value(pageName)),
    );
  }

  Future<void> updateInitialSetupFirstChatBackupCreated(bool? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        firstChatBackupCreated: Value(value),
      ),
    );
  }

  Future<void> clearInitialSetupProgress() async {
    await (delete(initialSetupProgress)..where((t) => t.id.equals(SingleRowTable.ID.value))).go();
  }

  Future<void> updateEditProfileProgress(EditProfileProgressEntry entry) async {
    await into(editProfileProgress).insertOnConflictUpdate(
      EditProfileProgressCompanion.insert(
        id: SingleRowTable.ID,
        age: Value(entry.age),
        name: Value(entry.name),
        profileText: Value(entry.profileText),
        jsonProfileAttributes: Value(entry.profileAttributes?.toJsonList()),
        unlimitedLikes: Value(entry.unlimitedLikes),
        jsonProfileImages: Value(entry.profileImages?.toJsonList()),
      ),
    );
  }

  Future<void> setProfileEditingInProgressStatus(bool value) async {
    await into(editProfileProgress).insertOnConflictUpdate(
      EditProfileProgressCompanion.insert(id: SingleRowTable.ID, editingInProgress: Value(value)),
    );
  }

  Future<void> setProfileSelectingImageStatus(bool value) async {
    await into(editProfileProgress).insertOnConflictUpdate(
      EditProfileProgressCompanion.insert(id: SingleRowTable.ID, selectingImage: Value(value)),
    );
  }

  Future<void> updateDraftMessage(api.AccountId accountId, String message) async {
    await into(
      draftMessage,
    ).insertOnConflictUpdate(DraftMessageCompanion.insert(accountId: accountId, message: message));
  }
}
