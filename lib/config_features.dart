import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:flutter/foundation.dart';

const bool FEATURE_ADMIN = kIsWeb;

/// Enable user facing UI for association membership management
const bool FEATURE_ASSOCIATION_MEMBERSHIP = kIsWeb;

/// Enable user facing UI for age verification
const bool FEATURE_AGE_VERIFICATION = kIsWeb;

/// Enable user facing UI for account verification
const bool FEATURE_ACCOUNT_VERIFICATION = kIsWeb;

/// Enable user facing UI for custom reports without content
const bool FEATURE_CUSTOM_REPORT_EMPTY = kIsWeb;

/// Enable user facing UI for custom reports with string content
const bool FEATURE_CUSTOM_REPORT_STRING = true;

/// Enable user facing UI for sending feedback to the server admins.
const bool FEATURE_FEEDBACK = true;

/// Enable skipping the initial setup
const bool FEATURE_INITIAL_SETUP_SKIP = kIsWeb;

/// Genders for which the security selfie screen is shown in the initial setup
const Set<Gender> FEATURE_INITIAL_SETUP_SECURITY_SELFIE_GENDERS = {Gender.man};

/// Genders which must have a security selfie.
const Set<Gender> FEATURE_SECURITY_SELFIE_GENDERS = {Gender.man};

/// Genders for which all profile picture requirements from the client config
/// are enforced in the initial setup profile pictures screen.
///
/// All genders must select at least one profile picture. Genders not in this
/// set can skip the other requirements (e.g. face detection).
const Set<Gender> FEATURE_INITIAL_SETUP_PROFILE_PICTURES_ENFORCE_ALL_REQUIREMENTS = {Gender.man};

/// Genders which must have a public profile to be able to view profiles.
///
/// Genders not in this set can view profiles even when their own profile is
/// private. They are shown an info banner about their profile being hidden.
const Set<Gender> FEATURE_PROFILE_VIEWING_REQUIRES_PUBLIC_PROFILE_GENDERS = {Gender.man};

/// Genders for which all profile viewing requirements from the client config
/// are enforced when viewing profiles.
///
/// Genders not in this set can view profiles even when the client config
/// requirements (e.g. face detection) are not met.
const Set<Gender> FEATURE_PROFILE_VIEWING_ENFORCE_ALL_REQUIREMENTS_GENDERS = {Gender.man};

/// Genders for which the face not detected error is shown when editing the
/// profile.
const Set<Gender> FEATURE_PROFILE_EDITING_ENFORCE_ALL_REQUIREMENTS_GENDERS = {Gender.man};

/// Enable showing the attribution text in the about dialog
const bool FEATURE_ABOUT_DIALOG_ATTRIBUTION = kIsWeb;

/// Enable user facing UI for video calls
const bool FEATURE_VIDEO_CALLS = false;

const bool FEATURE_SERVER_SELECTION = !kReleaseMode;
const bool FEATURE_DEBUG_SETTINGS = !kReleaseMode;
