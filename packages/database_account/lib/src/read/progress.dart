import 'package:database_account/src/database.dart';
import 'package:database_model/database_model.dart'
    show InitialSetupProgressEntry, EditProfileProgressEntry;
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../schema.dart' as schema;

part 'progress.g.dart';

@DriftAccessor(tables: [schema.InitialSetupProgress, schema.EditProfileProgress])
class DaoReadProgress extends DatabaseAccessor<AccountDatabase> with _$DaoReadProgressMixin {
  DaoReadProgress(super.db);

  Future<bool> isEditProfileEditingInProgress() async {
    return (await (select(
              editProfileProgress,
            )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull())
            ?.editingInProgress ??
        false;
  }

  Future<bool> isEditProfileSelectingImage() async {
    return (await (select(
          editProfileProgress,
        )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull())?.selectingImage ??
        false;
  }

  // Initial setup progress - watch entire row as a model
  Stream<InitialSetupProgressEntry?> watchInitialSetupProgress() {
    return (select(
      initialSetupProgress,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      if (r == null) return null;
      return InitialSetupProgressEntry(
        email: r.email,
        isAdult: r.isAdult,
        profileName: r.profileName,
        profileAge: r.profileAge,
        securitySelfieContentId: r.securitySelfieContentId,
        securitySelfieFaceDetected: r.securitySelfieFaceDetected,
        profileImages: r.jsonProfileImages?.value,
        gender: r.gender,
        searchSettingMen: r.searchSettingMen,
        searchSettingWomen: r.searchSettingWomen,
        searchSettingNonBinary: r.searchSettingNonBinary,
        searchAgeRangeInitDone: r.searchAgeRangeInitDone,
        searchAgeRangeMin: r.searchAgeRangeMin,
        searchAgeRangeMax: r.searchAgeRangeMax,
        latitude: r.latitude,
        longitude: r.longitude,
        profileAttributes: r.jsonProfileAttributes?.value,
        chatInfoUnderstood: r.chatInfoUnderstood,
      );
    });
  }

  Stream<String?> watchInitialSetupCurrentPage() {
    return (select(initialSetupProgress)..where((t) => t.id.equals(SingleRowTable.ID.value)))
        .map((r) => r.currentPage)
        .watchSingleOrNull();
  }

  Stream<EditProfileProgressEntry?> watchEditProfileProgress() {
    return (select(
      editProfileProgress,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      if (r == null) return null;
      return EditProfileProgressEntry(
        age: r.age,
        name: r.name,
        profileText: r.profileText,
        profileAttributes: r.jsonProfileAttributes?.value,
        unlimitedLikes: r.unlimitedLikes,
        profileImages: r.jsonProfileImages?.value,
      );
    });
  }
}
