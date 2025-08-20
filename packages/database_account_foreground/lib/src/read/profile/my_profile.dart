import 'package:database_account_foreground/src/database.dart';
import 'package:database_converter/database_converter.dart';
import 'package:database_model/database_model.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'my_profile.g.dart';

@DriftAccessor(tables: [schema.MyProfile, schema.ProfileLocation, schema.InitialProfileAge])
class DaoReadMyProfile extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoReadMyProfileMixin {
  DaoReadMyProfile(super.db);

  /// Get ProileEntry for my profile
  Stream<MyProfileEntry?> getProfileEntryForMyProfile() => Rx.combineLatest3(
    watchColumnMyProfile((r) => r),
    db.read.myMedia.watchMyAllProfileContent(),
    db.read.loginSession.watchAccountId(),
    (r, content, id) => _toMyProfileEntry(r, content, id),
  );

  MyProfileEntry? _toMyProfileEntry(MyProfileData? r, List<MyContent> content, api.AccountId? id) {
    if (r == null) {
      return null;
    }

    final profileName = r.profileName;
    final profileNameAccepted = r.profileNameAccepted;
    final profileNameModerationState = r.profileNameModerationState?.value;
    final profileText = r.profileText;
    final profileTextAccepted = r.profileTextAccepted;
    final profileTextModerationState = r.profileTextModerationState?.value;
    final profileTextModerationRejectedCategory = r.profileTextModerationRejectedCategory;
    final profileTextModerationRejectedDetails = r.profileTextModerationRejectedDetails;
    final profileAge = r.profileAge;
    final profileAttributes = r.jsonProfileAttributes?.value.toProfileAttributesMap();
    final profileVersion = r.profileVersion;
    final profileContentVersion = r.profileContentVersion;
    final profileUnlimitedLikes = r.profileUnlimitedLikes;

    final gridCropSize = r.primaryContentGridCropSize ?? 1.0;
    final gridCropX = r.primaryContentGridCropX ?? 0.0;
    final gridCropY = r.primaryContentGridCropY ?? 0.0;

    if (id != null &&
        profileName != null &&
        profileNameAccepted != null &&
        profileText != null &&
        profileTextAccepted != null &&
        profileAge != null &&
        profileAttributes != null &&
        profileVersion != null &&
        profileContentVersion != null &&
        profileUnlimitedLikes != null) {
      return MyProfileEntry(
        accountId: id,
        myContent: content,
        primaryContentGridCropSize: gridCropSize,
        primaryContentGridCropX: gridCropX,
        primaryContentGridCropY: gridCropY,
        name: profileName,
        nameAccepted: profileNameAccepted,
        profileNameModerationState: profileNameModerationState,
        profileText: profileText,
        profileTextAccepted: profileTextAccepted,
        profileTextModerationState: profileTextModerationState,
        profileTextModerationRejectedCategory: profileTextModerationRejectedCategory,
        profileTextModerationRejectedDetails: profileTextModerationRejectedDetails,
        age: profileAge,
        unlimitedLikes: profileUnlimitedLikes,
        attributeIdAndStateMap: profileAttributes,
        version: profileVersion,
        contentVersion: profileContentVersion,
      );
    } else {
      return null;
    }
  }

  Stream<Map<int, api.ProfileAttributeValueUpdate>?> watchMyProfileAttributes() =>
      watchColumnMyProfile((r) => r.jsonProfileAttributes?.value.toProfileAttributesMap());

  Stream<T?> watchColumnMyProfile<T extends Object>(T? Function(MyProfileData) extractColumn) {
    return (select(
      myProfile,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<InitialAgeInfo?> watchInitialAgeInfo() {
    return (select(initialProfileAge)..where((t) => t.id.equals(SingleRowTable.ID.value))).map((r) {
      final age = r.initialProfileAge;
      final ageSetUnixTime = r.initialProfileAgeSetUnixTime;

      if (age != null && ageSetUnixTime != null) {
        return InitialAgeInfo(age, ageSetUnixTime);
      } else {
        return null;
      }
    }).watchSingleOrNull();
  }

  Stream<api.Location?> watchProfileLocation() =>
      (select(profileLocation)..where((t) => t.id.equals(SingleRowTable.ID.value))).map((r) {
        final latitude = r.latitude;
        final longitude = r.longitude;
        if (latitude != null && longitude != null) {
          return api.Location(latitude: latitude, longitude: longitude);
        } else {
          return null;
        }
      }).watchSingleOrNull();
}
