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

/// Enable skipping the initial setup
const bool FEATURE_INITIAL_SETUP_SKIP = kIsWeb;

const bool FEATURE_SERVER_SELECTION = !kReleaseMode;
const bool FEATURE_DEBUG_SETTINGS = !kReleaseMode;
