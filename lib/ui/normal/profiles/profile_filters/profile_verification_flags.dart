import 'package:app/ui_utils/extensions/api.dart';
import 'package:openapi/api.dart';

class ProfileVerificationStatusFlags {
  static const int faceVerified = 1;
  static const int securityContentVerified = 2;
  static const int profileAgeVerified = 4;
  static const int profileNameVerified = 8;
}

bool hasAnyAccountVerificationCompleted(int verificationStatus) {
  final securityContentVerified =
      verificationStatus & ProfileVerificationStatusFlags.securityContentVerified != 0;
  final profileAgeRangeVerified =
      verificationStatus & ProfileVerificationStatusFlags.profileAgeVerified != 0;
  final profileNameVerified =
      verificationStatus & ProfileVerificationStatusFlags.profileNameVerified != 0;

  return securityContentVerified || profileAgeRangeVerified || profileNameVerified;
}

bool shouldShowAccountVerificationRequiredLimit({
  required AccountVerificationMethodsConfig? methods,
  required int myProfileVerificationStatus,
}) {
  if (methods.allDisabled) {
    return false;
  }

  return !hasAnyAccountVerificationCompleted(myProfileVerificationStatus);
}
