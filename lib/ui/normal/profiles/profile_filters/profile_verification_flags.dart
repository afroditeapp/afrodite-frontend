class ProfileVerificationStatusFlags {
  static const int faceVerifiedAny = 1;
  static const int faceVerifiedAll = 2;
  static const int securityContentVerified = 4;
  static const int profileAgeVerified = 8;
  static const int profileNameVerified = 16;
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
