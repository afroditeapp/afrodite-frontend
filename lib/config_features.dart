import 'package:flutter/foundation.dart';

const bool FEATURE_ADMIN = kIsWeb;

/// Enable user facing UI for association membership management
const bool FEATURE_ASSOCIATION_MEMBERSHIP = kIsWeb;

/// Enable user facing UI for age verification
const bool FEATURE_AGE_VERIFICATION = kIsWeb;

const bool FEATURE_DEBUG_SETTINGS = !kReleaseMode;
