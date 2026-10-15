import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/profile_pictures.dart";
import "package:app/utils/model.dart";
import "package:database/database.dart";
import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";

part 'security_selfie.freezed.dart';

@freezed
class SecuritySelfieData with _$SecuritySelfieData, UpdateStateProvider {
  const SecuritySelfieData._();

  factory SecuritySelfieData({
    MyContent? securityContent,
    DataConsentSettings? dataConsentSettings,
    @Default(UpdateIdle()) UpdateState updateState,
    required EditedSecuritySelfieData edited,
  }) = _SecuritySelfieData;

  ContentId? get currentSecurityContent => securityContent?.id;

  AccountImageId? _currentSecurityImageId(AccountId accountId) {
    final c = securityContent;
    if (c == null) {
      return null;
    }
    return AccountImageId(
      accountId,
      c.id,
      c.faceDetected,
      c.state,
      rejectedCategory: c.rejectedCategory,
      rejectedDetails: c.rejectedDetails,
    );
  }

  AccountImageId? valueSecurityContent(AccountId accountId) =>
      edited.securityContent.editedValue(_currentSecurityImageId(accountId));

  bool valueAllowFaceVerification() =>
      edited.allowFaceVerification ?? dataConsentSettings?.allowFaceVerification ?? false;

  bool unsavedChanges() =>
      edited.securityContent.unsavedChanges() || edited.allowFaceVerification != null;
}

@freezed
class EditedSecuritySelfieData with _$EditedSecuritySelfieData {
  const EditedSecuritySelfieData._();

  factory EditedSecuritySelfieData({
    @Default(NoEdit()) EditValue<AccountImageId> securityContent,
    bool? allowFaceVerification,
  }) = _EditedSecuritySelfieData;
}
