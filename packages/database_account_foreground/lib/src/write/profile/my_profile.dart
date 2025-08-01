
import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:database_converter/database_converter.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';

import '../../schema.dart' as schema;

part 'my_profile.g.dart';

@DriftAccessor(
  tables: [
    schema.MyProfile,
    schema.ProfileLocation,
    schema.ProfileInitialAgeInfo,
  ]
)
class DaoWriteMyProfile extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoWriteMyProfileMixin {
  DaoWriteMyProfile(super.db);

  Future<void> setApiProfile({
    required api.GetMyProfileResult result,
  }) async {
    final profile = result.p;
    await into(myProfile).insertOnConflictUpdate(
      MyProfileCompanion.insert(
        id: SingleRowTable.ID,
        profileName: Value(profile.name),
        profileNameAccepted: Value(profile.nameAccepted),
        profileNameModerationState: Value(result.nameModerationInfo?.state.toEnumString()),
        profileText: Value(profile.ptext),
        profileTextAccepted: Value(result.p.ptextAccepted),
        profileTextModerationState: Value(result.textModerationInfo?.state.toEnumString()),
        profileTextModerationRejectedCategory: Value(result.textModerationInfo?.rejectedReasonCategory),
        profileTextModerationRejectedDetails: Value(result.textModerationInfo?.rejectedReasonDetails),
        profileAge: Value(profile.age),
        profileVersion: Value(result.v),
        profileUnlimitedLikes: Value(profile.unlimitedLikes),
        jsonProfileAttributes: Value(profile.attributes.toJsonList()),
      ),
    );
  }

  Future<void> dbInternalMethodUpdateContentInfo({
    required api.GetMediaContentResult info,
  }) async {
      final content = info.profileContent;
      await into(myProfile).insertOnConflictUpdate(
        MyProfileCompanion.insert(
          id: SingleRowTable.ID,
          primaryContentGridCropSize: Value(content.gridCropSize),
          primaryContentGridCropX: Value(content.gridCropX),
          primaryContentGridCropY: Value(content.gridCropY),
          profileContentVersion: Value(info.profileContentVersion),
        ),
      );
  }

  Future<void> setInitialAgeInfo({
    required api.AcceptedProfileAges info,
  }) async {
    final time = UtcDateTime.fromUnixEpochMilliseconds(info.profileInitialAgeSetUnixTime.ut * 1000);
    await into(profileInitialAgeInfo).insertOnConflictUpdate(
      ProfileInitialAgeInfoCompanion.insert(
        id: SingleRowTable.ID,
        profileInitialAge: Value(info.profileInitialAge),
        profileInitialAgeSetUnixTime: Value(time),
      ),
    );
  }

  Future<void> updateProfileLocation({required double latitude, required double longitude}) async {
    await into(profileLocation).insertOnConflictUpdate(
      ProfileLocationCompanion.insert(
        id: SingleRowTable.ID,
        latitude: Value(latitude),
        longitude: Value(longitude),
      ),
    );
  }
}
