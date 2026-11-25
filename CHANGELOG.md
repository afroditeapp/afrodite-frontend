# Changelog

## [Unreleased]

### Added

- Add "View media content (advanced)" admin screen

### Changed

- Show moderator info and hide less used actions behind an app bar
  toggle on the admin image management screen

### Fixed

- Fix a layout crash in the profile attribute filter value selection screen

## [0.27.1] - 2026-11-23

### Added

- Add optional "Send feedback" settings item which opens the configured
  feedback email address
- Add "Account ID for support requests" screen which shows the account
  email address in a large, copyable format

### Changed

- Make email addresses selectable on the account settings screen

## [0.27.0] - 2026-11-23

### Added

- Add sent likes screen

### Changed

- Move initial setup basic details screens before the security selfie screen.
- Hide zero values from the multiple metrics chart tooltip
- Disable video calling features by default
- Ask the security selfie screen in the initial setup only for men
  (configurable per gender)
- Enforce all profile picture requirements in the initial setup only for men
  (configurable per gender). All genders must still select at least one
  profile picture.
- Allow viewing profiles with a private profile for genders which are not
  required to have a public profile (configurable per gender). An info banner
  about the hidden profile is shown instead of the blocking screen.
- Enforce all profile viewing requirements from the client config only for men
  (configurable per gender). Other genders can view profiles even when the
  requirements (e.g. face detection) are not met.
- Require a security selfie only for men (configurable per gender). Other
  genders can view profiles without a security selfie.
- Show the content management screen even when the account has no security
  selfie.
- Show the face not detected error when editing the profile only for men
  (configurable per gender).
- Don't require face detection from other profiles' primary picture when
  displaying received profiles.
- Clarify privacy settings switch descriptions to consistently describe
  what others can see about you
- Show Android SDK version and strong integrity verdict on the admin
  login management screen and in the admin account browsing list
- Show a description of the security selfie and an add image button
  when no security selfie is set on the security selfie screen

### Fixed

- Save profile privacy settings to the local database during initial
  setup so that the privacy settings screen shows the selected values
- Show an error message with a retry button on the blocked profiles
  screen when loading the blocked profiles fails
- Improve loading of private profiles
- Skip profiles which have a rejected primary profile picture instead of
  showing an error
- Fix database error when the same image is cached concurrently by targeting
  the unique cache entry key in the cache database upsert and returning the
  id of the existing row

## [0.26.1] - 2026-11-09

### Added

- Add admin "Latest content" screen for browsing latest profile names,
  profile texts and media content
- Add admin "View accounts (advanced)" screen for filtering accounts and
  selecting which extra info is shown while browsing accounts

### Changed

- Allow rejecting media content with rejection reason details on the
  admin content management screen
- Show image usage info on the admin content management screen
- Show online status and last seen time on the admin login management
  screen

## [0.26.0] - 2026-11-05

### Changed

- Allow '+' character in local part of email address
- Reorganize admin tasks UI
- Refresh admin task list item silently when returning from a task screen

### Fixed

- Show moderator tasks reports item when user has report processing
  permission but no profile name moderation permission

## [0.25.5] - 2026-11-02

### Added

- Show which type of admin banned the account on the account banned screen

### Changed

- Improve AI face verification description strings

### Fixed

- Breaking change: Fix admin API post_set_news_publicity HTTP method from
  DELETE to POST.

## [0.25.4] - 2026-10-28

- DB stability
- User API stability
